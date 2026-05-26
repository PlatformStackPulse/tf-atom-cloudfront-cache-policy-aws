output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the cache policy"
  value       = try(aws_cloudfront_cache_policy.this[0].id, null)
}

output "etag" {
  description = "Current version of the cache policy"
  value       = try(aws_cloudfront_cache_policy.this[0].etag, null)
}
