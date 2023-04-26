variable "sub_node" {
  type        = string
  description = "The subscription scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created."
  default     = "/subscriptions/25229114-2ec3-4b44-bb5b-649a554894bc"
}

variable initiative_name {
  type        = string
  description = "Policy initiative name. Changing this forces a new resource to be created"

  validation {
    condition     = length(var.initiative_name) <= 64
    error_message = "Initiative names have a maximum 64 character limit."
  }
}

variable initiative_display_name {
  type        = string
  description = "Policy initiative display name"

  validation {
    condition     = length(var.initiative_display_name) <= 128
    error_message = "Initiative display names have a maximum 128 character limit."
  }
}

variable initiative_description {
  type        = string
  description = "Policy initiative description"
  default     = ""

  validation {
    condition     = length(var.initiative_description) <= 512
    error_message = "Initiative descriptions have a maximum 512 character limit."
  }
}

variable initiative_category {
  type        = string
  description = "The category of the initiative"
  default     = "General"
}

variable initiative_version {
  type        = string
  description = "The version for this initiative, defaults to 1.0.0"
  default     = "1.0.0"
}

variable member_definitions {
  type        = any
  description = "Policy Defenition resource nodes that will be members of this initiative"
}

variable initiative_metadata {
  type        = any
  description = "The metadata for the policy initiative. This is a JSON object representing additional metadata that should be stored with the policy initiative. Omitting this will default to merge var.initiative_category and var.initiative_version"
  default     = null
}

variable merge_effects {
  type        = bool
  description = "Should the module merge all member definition effects? Defauls to true"
  default     = true
}

variable merge_parameters {
  type        = bool
  description = "Should the module merge all member definition parameters? Defauls to true"
  default     = true
}

locals {
  # colate all definition parameters into a single object
  member_parameters = {
    for d in var.member_definitions :
    d.name => try(jsondecode(d.parameters), {})
  }

  # combine all discovered definition parameters using interpolation
  parameters = merge(values({
    for definition, params in local.member_parameters :
    definition => {
      for parameter_name, parameter_value in params :
      # if do not merge parameters (or only effects) then suffix parameters with definition references
      var.merge_parameters == false || parameter_name == "effect" && var.merge_effects == false ?
        "${parameter_name}_${replace(substr(title(replace(definition, "/-|_|\\s/", " ")), 0, 64), "/\\s/", "")}" :

      parameter_name => {
        for k, v in parameter_value :
          k => (
            # if do not merge parameters (or only effects) then suffix displayNames with definition references
            k == "metadata" && var.merge_parameters == false || var.merge_effects == false && try(v.displayName,"") == "Effect" ?
              merge(v, { displayName = "${v.displayName} For Policy: ${replace(substr(title(replace(definition, "/-|_|\\s/", " ")), 0, 64), "/\\s/", "")}" }) :
            v
          )
      }
    }
  })...)

  # get role definition IDs
  role_definition_ids = {
    for d in var.member_definitions :
    d.name => try(jsondecode(d.policy_rule).then.details.roleDefinitionIds, [])
  }

  # combine all discovered role definition IDs
  all_role_definition_ids = try(distinct([for v in flatten(values(local.role_definition_ids)) : lower(v)]), [])

  metadata = coalesce(var.initiative_metadata, merge({ category = var.initiative_category },{ version = var.initiative_version }))

  # manually generate the initiative Id to prevent "Invalid for_each argument" on potential consumer modules
  initiative_id = var.sub_node_id != null ? "${var.sub_node_id}/providers/Microsoft.Authorization/policySetDefinitions/${var.initiative_name}" : azurerm_policy_set_definition.set.id
}
