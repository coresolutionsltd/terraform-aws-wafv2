[![alt text](https://coresolutions.ltd/media/core-solutions-82.png "Core Solutions")](https://coresolutions.ltd)

[![maintained by Core Solutions](https://img.shields.io/badge/maintained%20by-coresolutions.ltd-00607c.svg)](https://coresolutions.ltd)
[![GitHub tag](https://img.shields.io/github/v/tag/coresolutions-ltd/terraform-aws-wafv2.svg?label=latest)](https://github.com/coresolutions-ltd/terraform-aws-wafv2/releases)
[![Terraform Version](https://img.shields.io/badge/terraform-~%3E%200.12-623ce4.svg)](https://github.com/hashicorp/terraform/releases)
[![License](https://img.shields.io/badge/License-Apache%202.0-brightgreen.svg)](https://opensource.org/licenses/Apache-2.0)

# WAFv2 Terraform Module

A Terraform module to handle the creation of all things WAF

## Getting Started

```sh
module "waf" {
    source  = "coresolutions-ltd/wafv2/aws"

    name_preifx = "MyAwsomeWAF"
    default_action = "block"
    scope          = "REGIONAL"
    rate_limit     = 1000
    host_header    = "example.com"
    managed_rules = ["AWSManagedRulesCommonRuleSet",
                     "AWSManagedRulesAmazonIpReputationList",
                     "AWSManagedRulesKnownBadInputsRuleSet"]
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |
| random | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| default\_action | Default WAF action, can be either `allow` or `block` | `string` | `"allow"` | no |
| denylist | IP denylist | `list` | `[]` | no |
| host\_header | `Host` header value to match, requests with this host header will be allowed. | `string` | `null` | no |
| managed\_rules | Managed AWS rules to be applied to the web ACL | `list(string)` | `[]` | no |
| name\_prefix | Name prefix for all resources | `string` | `"Core"` | no |
| origin\_token | `X-Origin-Token` header value, requests with this header will be allowed. | `string` | `null` | no |
| rate\_limit | Allowable rate of requests for each originating IP address in any 5 minute time span | `number` | `null` | no |
| scope | Scope to be applied, must be either `REGIONAL` or `CLOUDFRONT` | `string` | `"REGIONAL"` | no |
| tags | A map of tags to add to resources | `map(string)` | `{}` | no |
| whitelist | IP whitelist | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| waf\_arn | The WebACL ARN |
| waf\_id | The WebACL ID |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
