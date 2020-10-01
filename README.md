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
    version = "~> 0.0.1"

    name_preifx = "MyAwsomeWAF"
    default_action = "allow"
    scope          = "REGIONAL"
    rate_limit     = 10000
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Providers

| Name   | Version |
| ------ | ------- |
| aws    | ~> 3.0  |
| random | ~> 2.0  |

## Inputs

| Name           | Description                                                                                                           | Type           | Default      | Required |
| -------------- | --------------------------------------------------------------------------------------------------------------------- | -------------- | ------------ | :------: |
| default_action | Default WAF action, can be either `allow` or `block`                                                                  | `string`       | `"allow"`    |    no    |
| denylist       | IP denylist                                                                                                           | `list`         | `[]`         |    no    |
| managed_rules  | Managed AWS rules to be applied to the web ACL                                                                        | `list(string)` | `[]`         |    no    |
| name_prefix    | Name prefix for all resources                                                                                         | `string`       | `"Core"`     |    no    |
| origin_token   | `X-Origin-Token` header value, requests with this header will be allowed, this is useful when restricting ALB traffic | `string`       | `null`       |    no    |
| rate_limit     | Allowable rate of requests for each originating IP address in any 5 minute time span                                  | `number`       | `null`       |    no    |
| scope          | Scope to be applied, must be either `REGIONAL` or `CLOUDFRONT`                                                        | `string`       | `"REGIONAL"` |    no    |
| tags           | A map of tags to add to resources                                                                                     | `map(string)`  | `{}`         |    no    |
| whitelist      | IP whitelist                                                                                                          | `list`         | `[]`         |    no    |

## Outputs

| Name    | Description    |
| ------- | -------------- |
| waf_arn | The WebACL ARN |
| waf_id  | The WebACL ID  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
