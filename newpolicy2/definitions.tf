module "deny_nic_public_ip" {
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

module "storage_min_tls" {
  source              = "..//modules/definition"
  policy_name         = "storage_min_tls"
  display_name        = "Storage Accounts should have min tls"
  policy_category     = "General"
}