module "Azure Security Benchmark" {
  source                  = "..//modules/initiative"
  initiative_name         = "Azure Security Benchmark"
  initiative_display_name = "[Security]: Azure Security BenchMark"
  initiative_description  = "The Azure Security Benchmark initiative represents the policies and controls implementing security recommendations defined in Azure Security Benchmark v3, see https://aka.ms/azsecbm. This also serves as the Microsoft Defender for Cloud default policy initiative. You can directly assign this initiative, or manage its policies and compliance results within Microsoft Defender for Cloud."
  initiative_category     = "Security Center"
}
