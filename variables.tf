variable "comment" {
  description = "Comment for the cache policy"
  type        = string
  default     = null
}

variable "default_ttl" {
  description = "Default TTL in seconds"
  type        = number
  default     = 86400
}

variable "max_ttl" {
  description = "Maximum TTL in seconds"
  type        = number
  default     = 31536000
}

variable "min_ttl" {
  description = "Minimum TTL in seconds"
  type        = number
  default     = 0
}

variable "cookie_behavior" {
  description = "Cookie behavior (none, whitelist, allExcept, all)"
  type        = string
  default     = "none"
}

variable "cookie_items" {
  description = "List of cookie names"
  type        = list(string)
  default     = null
}

variable "header_behavior" {
  description = "Header behavior (none, whitelist)"
  type        = string
  default     = "none"
}

variable "header_items" {
  description = "List of header names"
  type        = list(string)
  default     = null
}

variable "query_string_behavior" {
  description = "Query string behavior (none, whitelist, allExcept, all)"
  type        = string
  default     = "none"
}

variable "query_string_items" {
  description = "List of query string keys"
  type        = list(string)
  default     = null
}

variable "enable_gzip" {
  description = "Enable gzip compression"
  type        = bool
  default     = true
}

variable "enable_brotli" {
  description = "Enable brotli compression"
  type        = bool
  default     = true
}
