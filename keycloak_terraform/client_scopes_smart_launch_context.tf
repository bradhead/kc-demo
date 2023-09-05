resource "keycloak_openid_client_scope" "fhir_context_scope" {
  realm_id               = data.keycloak_realm.realm.id
  name                   = "context"
  description            = "Permission to retrieve current logged-in user"
  consent_screen_text    = "Permission to retrieve current logged-in user"
  include_in_token_scope = true
}

resource "keycloak_openid_audience_protocol_mapper" "fhir_context_audience_mapper" {
  realm_id        = keycloak_openid_client_scope.fhir_context_scope.realm_id
  client_scope_id = keycloak_openid_client_scope.fhir_context_scope.id
  name            = "audience-mapper"
  add_to_id_token = true

  included_custom_audience = var.keycloak_environment.custom_audience
}
