module "Azure_Security_Benchmark" {
  source                  = "..//modules/initiative"
  initiative_name         = "Azure_Security1_Benchmark"
  initiative_display_name = "[Security123]: Azure Security BenchMark"
  initiative_description  = "The Azure Security Benchmark initiative represents the policies and controls implementing security recommendations defined in Azure Security Benchmark v3, see https://aka.ms/azsecbm. This also serves as the Microsoft Defender for Cloud default policy initiative. You can directly assign this initiative, or manage its policies and compliance results within Microsoft Defender for Cloud."
  initiative_category     = "Security Center"
  
 # Populate member_definitions with a for loop (explicit)
  member_definitions = [
    module.whitelist_regions.definition,
    module.storage_min_tls.definition
  ]
}
