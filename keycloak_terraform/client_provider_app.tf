resource "keycloak_openid_client" "client1" {
  realm_id                     = data.keycloak_realm.realm.id
  client_id                    = var.client_app1.id
  name                         = "Swiss App for Providers"
  description                  = "Example FHIR client"
  enabled                      = true
  access_type                  = "PUBLIC"
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = false
  login_theme                  = var.client_app1.login_theme
  valid_redirect_uris          = var.client_app1.valid_redirects
  web_origins                  = var.client_app1.web_origins
  base_url                     = var.client_app1.base_url
  full_scope_allowed           = false
  //authentication_flow_binding_overrides {
  //  browser_id = keycloak_authentication_flow.provider_login_flow.id
  //}
}

resource "keycloak_openid_client_default_scopes" "client1_default_scopes" {
  realm_id  = keycloak_openid_client.client1.realm_id
  client_id = keycloak_openid_client.client1.id

  default_scopes = [
    "web-origins"
  ]
}
resource "keycloak_openid_client_optional_scopes" "client1_optional_scopes" {
  realm_id  = keycloak_openid_client.client1.realm_id
  client_id = keycloak_openid_client.client1.id

  optional_scopes = [
    "profile",
    "offline_access",
    keycloak_openid_client_scope.fhir_user_scope.name,
    keycloak_openid_client_scope.patient_all_scope.name,
    keycloak_openid_client_scope.user_all_scope.name
  ]
}

resource "keycloak_generic_role_mapper" "client_status_role_md_mapper" {
  realm_id  = keycloak_openid_client.client1.realm_id
  client_id = keycloak_openid_client.client1.id
  role_id   = keycloak_role.realm_role_md.id
}

resource "keycloak_generic_role_mapper" "client_status_role_rnp_mapper" {
  realm_id  = keycloak_openid_client.client1.realm_id
  client_id = keycloak_openid_client.client1.id
  role_id   = keycloak_role.realm_role_rnp.id
}

resource "keycloak_generic_role_mapper" "client_status_role_moa_mapper" {
  realm_id  = keycloak_openid_client.client1.realm_id
  client_id = keycloak_openid_client.client1.id
  role_id   = keycloak_role.realm_role_moa.id
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client1_endorser_attribute_mapper" {
  realm_id            = keycloak_openid_client.client1.realm_id
  client_id           = keycloak_openid_client.client1.id
  name                = "endorser_data"
  user_attribute      = "endorser_data"
  claim_name          = "endorser_data"
  claim_value_type    = "String"
  multivalued         = true
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "user_realm_role_mapper" {
  realm_id            = keycloak_openid_client.client1.realm_id
  client_id           = keycloak_openid_client.client1.id
  name                = "user-realm-role-mapper"
  claim_name          = "provider_roles"
  multivalued         = true
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client1_profile" {
  realm_id            = keycloak_openid_client.client1.realm_id
  client_id           = keycloak_openid_client.client1.id
  name                = "profile"
  user_attribute      = "provider"
  claim_name          = "profile"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}


resource "keycloak_openid_user_session_note_protocol_mapper" "client1_idp_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client1.realm_id
  client_id        = keycloak_openid_client.client1.id
  name             = "user-session-idp-mapper"
  claim_name       = "idp"
  claim_value_type = "String"
  session_note     = "idp"
}

resource "keycloak_openid_user_session_note_protocol_mapper" "client1_acr_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client1.realm_id
  client_id        = keycloak_openid_client.client1.id
  name             = "user-session-acr-mapper"
  claim_name       = "acr"
  claim_value_type = "String"
  session_note     = "acr"
}
