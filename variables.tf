variable "openid_client_role_policies" {
  description = <<EOT
Map of openid_client_role_policies, attributes below
Required:
    - name
    - realm_id
    - resource_server_id
    - type
    - role (block):
        - id (required)
        - required (required)
Optional:
    - decision_strategy
    - description
    - fetch_roles
    - logic
EOT

  type = map(object({
    name               = string
    realm_id           = string
    resource_server_id = string
    type               = string
    decision_strategy  = optional(string)
    description        = optional(string)
    fetch_roles        = optional(bool)
    logic              = optional(string)
    role = list(object({
      id       = string
      required = bool
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.openid_client_role_policies : (
        length(v.role) >= 1
      )
    ])
    error_message = "Each role list must contain at least 1 items"
  }
  # Note: 1 additional provider-side validator is enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

