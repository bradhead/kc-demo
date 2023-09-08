resource "keycloak_openid_client" "client_smile" {
  realm_id                     = data.keycloak_realm.realm.id
  client_id                    = var.client_smile.id
  client_secret                = var.client_smile.client_secret
  name                         = "smile-cdr "
  description                  = "Smile CDR FHIR server"
  enabled                      = true
  access_type                  = "CONFIDENTIAL"
  standard_flow_enabled        = true
  implicit_flow_enabled        = false
  direct_access_grants_enabled = true
  login_theme                  = var.client_smile.login_theme
  valid_redirect_uris          = var.client_smile.valid_redirects
  web_origins                  = var.client_smile.web_origins
  base_url                     = var.client_smile.base_url
  full_scope_allowed           = false
}

resource "keycloak_openid_client_default_scopes" "client_smile_default_scopes" {
  realm_id  = keycloak_openid_client.client_smile.realm_id
  client_id = keycloak_openid_client.client_smile.id

  default_scopes = [
    "web-origins",
    "profile",
    "context",
  ]
}
resource "keycloak_openid_client_optional_scopes" "client_smile_optional_scopes" {
  realm_id  = keycloak_openid_client.client_smile.realm_id
  client_id = keycloak_openid_client.client_smile.id

  optional_scopes = [
    "offline_access",
    keycloak_openid_client_scope.fhir_user_scope.name
  ]
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_md_mapper" {
  realm_id  = keycloak_openid_client.client_smile.realm_id
  client_id = keycloak_openid_client.client_smile.id
  role_id   = keycloak_role.realm_role_md.id
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_rnp_mapper" {
  realm_id  = keycloak_openid_client.client_smile.realm_id
  client_id = keycloak_openid_client.client_smile.id
  role_id   = keycloak_role.realm_role_rnp.id
}

resource "keycloak_generic_role_mapper" "client_smile_status_role_moa_mapper" {
  realm_id  = keycloak_openid_client.client_smile.realm_id
  client_id = keycloak_openid_client.client_smile.id
  role_id   = keycloak_role.realm_role_moa.id
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client_smile_endorser_attribute_mapper" {
  realm_id            = keycloak_openid_client.client_smile.realm_id
  client_id           = keycloak_openid_client.client_smile.id
  name                = "endorser_data"
  user_attribute      = "endorser_data"
  claim_name          = "endorser_data"
  claim_value_type    = "String"
  multivalued         = true
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "client_smile_user_realm_role_mapper" {
  realm_id            = keycloak_openid_client.client_smile.realm_id
  client_id           = keycloak_openid_client.client_smile.id
  name                = "user-realm-role-mapper"
  claim_name          = "provider_roles"
  multivalued         = true
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client_smile_profile" {
  realm_id            = keycloak_openid_client.client_smile.realm_id
  client_id           = keycloak_openid_client.client_smile.id
  name                = "profile"
  user_attribute      = "fhirUser"
  claim_name          = "profile"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}


resource "keycloak_openid_user_session_note_protocol_mapper" "client_smile_idp_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client_smile.realm_id
  client_id        = keycloak_openid_client.client_smile.id
  name             = "user-session-idp-mapper"
  claim_name       = "idp"
  claim_value_type = "String"
  session_note     = "idp"
}

resource "keycloak_openid_user_session_note_protocol_mapper" "client_smile_acr_user_session_note_mapper" {
  realm_id         = keycloak_openid_client.client_smile.realm_id
  client_id        = keycloak_openid_client.client_smile.id
  name             = "user-session-acr-mapper"
  claim_name       = "acr"
  claim_value_type = "String"
  session_note     = "acr"
}

resource "keycloak_openid_user_attribute_protocol_mapper" "client_smile_patient_id" {
  realm_id            = keycloak_openid_client.client_smile.realm_id
  client_id           = keycloak_openid_client.client_smile.id
  name                = "hdid"
  user_attribute      = "hdid"
  claim_name          = "patient_hdid"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = true
}
