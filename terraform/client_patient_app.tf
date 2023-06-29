resource "keycloak_openid_client" "client2" {
  realm_id                     = data.keycloak_realm.realm.id
  client_id                    = var.client_app2.id
  name                         = "Swiss App Patient Portal"
  description                  = "Example API client"
  enabled                      = true
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = false
  consent_required             = true
  login_theme                  = var.client_app1.login_theme
  valid_redirect_uris          = var.client_app2.valid_redirects
  web_origins                  = var.client_app2.web_origins
  full_scope_allowed           = false
  base_url                     = var.client_app2.base_url
}

resource "keycloak_openid_client_default_scopes" "client2_default_scopes" {
  realm_id  = keycloak_openid_client.client2.realm_id
  client_id = keycloak_openid_client.client2.id

  default_scopes = [
  "web-origins"]
}
resource "keycloak_openid_client_optional_scopes" "client2_optional_scopes" {
  realm_id  = keycloak_openid_client.client2.realm_id
  client_id = keycloak_openid_client.client2.id

  optional_scopes = [
    "offline_access",
    "profile",
    keycloak_openid_client_scope.fhir_user_scope.name,
    keycloak_openid_client_scope.patient_all_read_scope.name
  ]
}


resource "keycloak_openid_user_attribute_protocol_mapper" "client2_patient_id" {
  realm_id            = keycloak_openid_client.client2.realm_id
  client_id           = keycloak_openid_client.client2.id
  name                = "hdid"
  user_attribute      = "hdid"
  claim_name          = "patient_hdid"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client2_profile" {
  realm_id            = keycloak_openid_client.client2.realm_id
  client_id           = keycloak_openid_client.client2.id
  name                = "profile"
  user_attribute      = "patient"
  claim_name          = "profile"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_session_note_protocol_mapper" "client2_idp_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client2.realm_id
  client_id        = keycloak_openid_client.client2.id
  name             = "user-session-idp-mapper"
  claim_name       = "idp"
  claim_value_type = "String"
  session_note     = "idp"
}

resource "keycloak_openid_user_session_note_protocol_mapper" "client2_acr_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client2.realm_id
  client_id        = keycloak_openid_client.client2.id
  name             = "user-session-acr-mapper"
  claim_name       = "acr"
  claim_value_type = "String"
  session_note     = "acr"
}


