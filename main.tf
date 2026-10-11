resource "keycloak_openid_client_role_policy" "openid_client_role_policies" {
  for_each = var.openid_client_role_policies

  name               = each.value.name
  realm_id           = each.value.realm_id
  resource_server_id = each.value.resource_server_id
  type               = each.value.type
  decision_strategy  = each.value.decision_strategy
  description        = each.value.description
  fetch_roles        = each.value.fetch_roles
  logic              = each.value.logic

  dynamic "role" {
    for_each = each.value.role
    content {
      id       = role.value.id
      required = role.value.required
    }
  }
}

