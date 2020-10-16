locals {
  name_prefix = var.name_prefix != "Core" ? var.name_prefix : "Core-${random_id.rand.0.dec}"
}

resource "random_id" "rand" {
  count       = var.name_prefix == "Core" ? 1 : 0
  byte_length = 4
}

resource "aws_wafv2_ip_set" "whitelist" {
  name               = "${local.name_prefix}-IPSet-Whitelist"
  description        = "Whitelist"
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.whitelist


  tags = merge(
    var.tags,
    {
      "Name" = "${local.name_prefix}-IPSet-Whitelist"
    },
  )
}

resource "aws_wafv2_ip_set" "denylist" {
  name               = "${local.name_prefix}-IPSet-Denylist"
  description        = "IP set containing explicitly denied IPs"
  scope              = var.scope
  ip_address_version = "IPV4"
  addresses          = var.denylist


  tags = merge(
    var.tags,
    {
      "Name" = "${local.name_prefix}-IPSet-Denylist"
    },
  )
}

resource "aws_wafv2_web_acl" "web_acl" {
  name        = "${local.name_prefix}-WAF"
  description = "Web ACL - ${local.name_prefix}"
  scope       = var.scope

  default_action {
    dynamic "allow" {
      for_each = var.default_action == "allow" ? [1] : []

      content {}
    }

    dynamic "block" {
      for_each = var.default_action == "block" ? [1] : []

      content {}
    }
  }

  rule {
    name     = "${local.name_prefix}-Denylist"
    priority = 10

    action {
      block {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.denylist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${local.name_prefix}DenyList"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "${local.name_prefix}-Whitelist"
    priority = 20

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.whitelist.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${local.name_prefix}WhiteList"
      sampled_requests_enabled   = false
    }
  }


  dynamic "rule" {
    for_each = var.origin_token != null ? [1] : []

    content {
      name     = "${local.name_prefix}-Detect-Origin-Token"
      priority = 30

      action {
        allow {}
      }

      statement {
        byte_match_statement {
          field_to_match {
            single_header {
              name = "x-origin-token"
            }
          }
          positional_constraint = "EXACTLY"
          search_string         = var.origin_token
          text_transformation {
            priority = 1
            type     = "NONE"
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${local.name_prefix}DetectOriginToken"
        sampled_requests_enabled   = false
      }
    }
  }

  dynamic "rule" {
    for_each = var.managed_rules

    content {
      name     = "${local.name_prefix}-${rule.value}"
      priority = 50 + index(var.managed_rules, rule.value)

      override_action {
        none {}
      }

      statement {
        managed_rule_group_statement {
          name        = rule.value
          vendor_name = "AWS"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${local.name_prefix}${rule.value}"
        sampled_requests_enabled   = false
      }

    }
  }

  dynamic "rule" {
    for_each = var.host_header != null ? [1] : []

    content {
      name     = "${local.name_prefix}-Detect-Host-Header"
      priority = 95

      action {
        allow {}
      }

      statement {
        byte_match_statement {
          field_to_match {
            single_header {
              name = "host"
            }
          }
          positional_constraint = "EXACTLY"
          search_string         = var.host_header
          text_transformation {
            priority = 1
            type     = "NONE"
          }
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${local.name_prefix}DetectOriginToken"
        sampled_requests_enabled   = false
      }
    }
  }

  dynamic "rule" {
    for_each = var.rate_limit != null ? [1] : []

    content {
      name     = "${local.name_prefix}-Ratelimiting"
      priority = 100

      action {
        block {}
      }

      statement {
        rate_based_statement {
          limit              = var.rate_limit
          aggregate_key_type = "IP"
        }
      }

      visibility_config {
        cloudwatch_metrics_enabled = false
        metric_name                = "${local.name_prefix}-Ratelimiting"
        sampled_requests_enabled   = false
      }

    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${local.name_prefix}CDefaultAction"
    sampled_requests_enabled   = false
  }

  tags = merge(
    var.tags,
    {
      "Name" = "${local.name_prefix}-WAF"
    }
  )
}
