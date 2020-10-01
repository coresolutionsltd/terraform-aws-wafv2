output "waf_id" {
  value       = aws_wafv2_web_acl.web_acl.id
  description = "The WebACL ID"
}

output "waf_arn" {
  value       = aws_wafv2_web_acl.web_acl.arn
  description = "The WebACL ARN"
}
