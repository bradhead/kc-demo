
resource "keycloak_default_roles" "default_roles" {
  realm_id = data.keycloak_realm.realm.id
  default_roles = [
    "uma_authorization",
    "user",
    "offline_access"
  ]
}

resource "keycloak_role" "realm_role_md" {
  realm_id    = data.keycloak_realm.realm.id
  name        = "MD"
  description = "Medical Doctor role"
  attributes = {
    key        = "attribute1"
    multivalue = "value1##value2"
  }
}

resource "keycloak_role" "realm_role_moa" {
  realm_id    = data.keycloak_realm.realm.id
  name        = "MOA"
  description = "Medical Office Assistant role"
  attributes = {
    key        = "attribute1"
    multivalue = "value1##value2"
  }
}

resource "keycloak_role" "realm_role_rnp" {
  realm_id    = data.keycloak_realm.realm.id
  name        = "RNP"
  description = "Registered Nurse Practitioner role"
  attributes = {
    key        = "attribute1"
    multivalue = "value1##value2"
  }
}
