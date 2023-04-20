module "deny_resource_types" {
  source              = "..//modules/definition"
  policy_name         = "deny_resource_types"
  display_name        = "Deny Azure Resource types"
  policy_category     = "General"
 }

module "whitelist_regions" {
  source              = "..//modules/definition"
  policy_name         = "whitelist_regions1"
  display_name        = "Whitelist Azure Regions"
  policy_category     = "General"
}