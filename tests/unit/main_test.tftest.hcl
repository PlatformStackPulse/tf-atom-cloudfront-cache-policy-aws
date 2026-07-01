# Unit Tests for tf-atom-cloudfront-cache-policy-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:         terraform test -test-directory=tests/unit
# Run verbose:      terraform test -test-directory=tests/unit -verbose
# Run specific:     terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# NOTE: Under a mock provider, computed attributes (id, etag) are UNKNOWN at
# plan time, so assertions target plan-KNOWN values: the module-enabled flag,
# the tf-label id string, and input pass-throughs.

mock_provider "aws" {}

variables {
  # tf-label context
  namespace = "eg"
  stage     = "test"
  name      = "thing"

  # module inputs (valid sample values)
  comment               = "unit-test cache policy"
  default_ttl           = 3600
  max_ttl               = 86400
  min_ttl               = 1
  cookie_behavior       = "whitelist"
  cookie_items          = ["session"]
  header_behavior       = "whitelist"
  header_items          = ["Authorization"]
  query_string_behavior = "whitelist"
  query_string_items    = ["v"]
  enable_gzip           = true
  enable_brotli         = true
}

# ---------------------------------------------------------------------------
# Test: module creates the cache policy when enabled
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "enabled output should be true when the module is enabled"
  }

  assert {
    condition     = aws_cloudfront_cache_policy.this[0].name == "eg-test-thing"
    error_message = "cache policy name should equal the tf-label id 'eg-test-thing'"
  }

  assert {
    condition     = length(aws_cloudfront_cache_policy.this) == 1
    error_message = "exactly one cache policy should be planned when enabled"
  }
}

# ---------------------------------------------------------------------------
# Test: inputs are forwarded to the resource
# ---------------------------------------------------------------------------
run "forwards_inputs" {
  command = plan

  assert {
    condition     = aws_cloudfront_cache_policy.this[0].default_ttl == 3600
    error_message = "default_ttl should be forwarded to the cache policy"
  }

  assert {
    condition     = aws_cloudfront_cache_policy.this[0].comment == "unit-test cache policy"
    error_message = "comment should be forwarded to the cache policy"
  }
}

# ---------------------------------------------------------------------------
# Test: disabling the module creates no resources
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = length(aws_cloudfront_cache_policy.this) == 0
    error_message = "no cache policy should be created when enabled = false"
  }

  assert {
    condition     = output.id == null
    error_message = "id output should be null when the module is disabled"
  }
}
