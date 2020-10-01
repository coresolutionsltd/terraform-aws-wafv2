variable "scope" {
  type        = string
  description = "Scope to be applied, must be either `REGIONAL` or `CLOUDFRONT`"
  default     = "REGIONAL"
}

variable "name_prefix" {
  description = "Name prefix for all resources"
  default     = "Core"
}

variable "whitelist" {
  type        = list
  default     = []
  description = "IP whitelist"
}

variable "denylist" {
  type        = list
  default     = []
  description = "IP denylist"
}

variable "default_action" {
  type        = string
  description = "Default WAF action, can be either `allow` or `block`"
  default     = "allow"
}

variable "rate_limit" {
  type        = number
  description = "Allowable rate of requests for each originating IP address in any 5 minute time span"
  default     = null
}

variable "managed_rules" {
  type        = list(string)
  description = "Managed AWS rules to be applied to the web ACL"
  default     = []
}

variable "origin_token" {
  type        = string
  description = "`X-Origin-Token` header value, requests with this header will be allowed, this is useful when restricting ALB traffic"
  default     = null
}

variable "tags" {
  description = "A map of tags to add to resources"
  type        = map(string)
  default     = {}
}
