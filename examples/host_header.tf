module "waf" {
  source = "coresolutions-ltd/wafv2/aws"

  # Default action will be block unless the host header is www.example.com
  default_action = "block"
  scope          = "REGIONAL"
  host_header    = "www.example.com"
}
