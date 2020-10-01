module "waf" {
  source = "coresolutions-ltd/wafv2/aws"

  default_action = "allow"
  scope          = "REGIONAL"
  managed_rules = ["AWSManagedRulesCommonRuleSet",
    "AWSManagedRulesAmazonIpReputationList",
    "AWSManagedRulesAdminProtectionRuleSet",
    "AWSManagedRulesKnownBadInputsRuleSet",
    "AWSManagedRulesLinuxRuleSet",
  "AWSManagedRulesUnixRuleSet"]
}
