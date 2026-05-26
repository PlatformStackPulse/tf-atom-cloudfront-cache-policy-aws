resource "aws_cloudfront_cache_policy" "this" {
  count = module.this.enabled ? 1 : 0

  name        = module.this.id
  comment     = var.comment
  default_ttl = var.default_ttl
  max_ttl     = var.max_ttl
  min_ttl     = var.min_ttl

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = var.cookie_behavior
      dynamic "cookies" {
        for_each = var.cookie_items != null ? [1] : []
        content {
          items = var.cookie_items
        }
      }
    }
    headers_config {
      header_behavior = var.header_behavior
      dynamic "headers" {
        for_each = var.header_items != null ? [1] : []
        content {
          items = var.header_items
        }
      }
    }
    query_strings_config {
      query_string_behavior = var.query_string_behavior
      dynamic "query_strings" {
        for_each = var.query_string_items != null ? [1] : []
        content {
          items = var.query_string_items
        }
      }
    }
    enable_accept_encoding_gzip   = var.enable_gzip
    enable_accept_encoding_brotli = var.enable_brotli
  }
}
