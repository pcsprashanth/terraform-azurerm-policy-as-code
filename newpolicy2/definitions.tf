module "deny_resource_types" {
  source              = "..//modules/definition"
  policy_name         = "deny_resource_types"
  display_name        = "Deny Azure Resource types"
  policy_category     = "General"
  subscription_id = "data.azurerm_subscription.current.id"
}

module "whitelist_regions" {
  source              = "..//modules/definition"
  policy_name         = "whitelist_regions"
  display_name        = "Whitelist Azure Regions"
  policy_category     = "General"
  subscription_id = "data.azurerm_subscription.current_id"
}