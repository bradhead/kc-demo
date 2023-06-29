
resource "keycloak_openid_user_attribute_protocol_mapper" "fhirUser_attribute_mapper" {
  realm_id            = data.keycloak_realm.realm.id
  client_scope_id     = keycloak_openid_client_scope.fhir_user_scope.id
  name                = "user-fhirUser-mapper"
  user_attribute      = "profile"
  claim_name          = "profile"
  multivalued         = false
  add_to_id_token     = true
  add_to_access_token = false
  add_to_userinfo     = true
}

resource "keycloak_openid_user_attribute_protocol_mapper" "idp_attribute_mapper" {
  realm_id            = data.keycloak_realm.realm.id
  client_scope_id     = data.keycloak_openid_client_scope.openid_profile_scope.id
  name                = "user-idp-mapper"
  user_attribute      = "idp"
  claim_name          = "idp"
  multivalued         = false
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = false
}



resource "keycloak_openid_user_attribute_protocol_mapper" "acr_attribute_mapper" {
  realm_id            = keycloak_openid_client.client1.realm_id
  client_scope_id     = data.keycloak_openid_client_scope.openid_profile_scope.id
  name                = "acr-mapper"
  user_attribute      = "acr"
  claim_name          = "acr"
  claim_value_type    = "String"
  add_to_id_token     = true
  add_to_access_token = true
  add_to_userinfo     = false
}