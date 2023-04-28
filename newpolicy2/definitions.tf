module "deny_resource_types" {
  source              = "..//modules/definition"
  policy_name         = "deny_resource_types"
  display_name        = "Deny Azure Resource types"
  policy_category     = "General"
 }

module "whitelist_regions" {
  source              = "..//modules/definition"
  policy_name         = "whitelist_regions"
  display_name        = "Whitelist Azure Regions"
  policy_category     = "General"
}
module "whitelist_resources" {
  source              = "..//modules/definition"
  policy_name         = "whitelist_resources"
  display_name        = "Allowed resources"
  policy_category     = "General"
}
module "deny_nat_rules_firewalls" {

  source              = "..//modules/definition"
  policy_name         = "deny_nat_rules_firewalls"
  display_name        = "deny_nat_rules_firewalls"
  policy_category     = "General"

}