resource "keycloak_user" "user1" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "alice"
  enabled    = true
  first_name = "Alice"
  last_name  = "Doctor"
  attributes = {
    practitionerId     = "1234",
    practitionerRole   = "doctor",
    practitionerStatus = "active",
    expertise          = "101##136##171",
    patient            = "https://fhir.server/Patient/3F80F903-6465-4A01-B808-F7605E0D25A0",
    provider           = "https://fhir.server/Provider/B3521F63-3F55-4F9F-8C1E-3DE11AAF1774",
    qualification      = "[{ \"class\":\"MD\", \"license_id\":\"12345\", \"status\":\"active\", \"start_date\":\"20230101\", \"msp_id\":\"2292993\"} , { \"class\":\"PHARM\", \"license_id\":\"34567\", \"status\":\"active\", \"start_date\":\"20221101\", \"msp_id\":\"333995\"}  ]",
    hdid               = "339495a393945b03939cdeaa993"
  }
  initial_password {
    value     = var.test_user_password
    temporary = false
  }
}

resource "keycloak_user_roles" "user1_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.user1.id

  role_ids = [
    keycloak_role.realm_role_md.id
  ]
}

resource "keycloak_user" "user2" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "moa"
  enabled    = true
  first_name = "Bob"
  last_name  = "Moa"
  attributes = {
    practitionerId     = "1234",
    practitionerRole   = "moa",
    practitionerStatus = "active",
    expertise          = "S31##515##168",
    patient            = "https://fhir.server/Patient/CF8B30A3-A85F-4EBE-A4E3-77425084AF6E",
    provider           = "https://fhir.server/Provider/15FEA569-BAE4-43FF-ABBF-E4171D7FF0AF",
    qualification      = "[{ \"code\":\"RN\", \"id\":\"3939393\", \"status\":\"active\", \"period_start\":\"20230204\", \"msp_id\":\"90999339\"} ]",
    endorser_data      = "CPN.00063660.BC.PRS##CPN.00099999.BC.PRS"
  }
  initial_password {
    value     = var.test_user_password
    temporary = false
  }
}

resource "keycloak_user_roles" "user2_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.user2.id

  role_ids = [
    keycloak_role.realm_role_moa.id
  ]
}

//-----------------------------------------  AUTOMATED TESTING USERS -------------------
resource "keycloak_user" "test_user1" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "md"
  enabled    = true
  first_name = "Terry"
  last_name  = "MD"
  initial_password {
    value     = var.test_user_password
    temporary = false
  }

}
resource "keycloak_user_roles" "test_user1_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.test_user1.id

  role_ids = [
    keycloak_role.realm_role_md.id
  ]
}

resource "keycloak_user" "test_user2" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "morgan"
  enabled    = true
  first_name = "Morgan"
  last_name  = "MOA"
  attributes = {
    endorser_data = "CPN.00063660.BC.PRS##CPN.00099999.BC.PRS",
    hdid          = "339495a393945b03939cdeaa993",

  }
  initial_password {
    value     = var.test_user_password
    temporary = false
  }
}

resource "keycloak_user_roles" "test_user2_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.test_user2.id

  role_ids = [
    keycloak_role.realm_role_moa.id
  ]
}

resource "keycloak_user" "test_user3" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "frank"
  enabled    = true
  first_name = "Frank"
  last_name  = "RNP"
  initial_password {
    value     = var.test_user_password
    temporary = false
  }
}

resource "keycloak_user_roles" "test_user3_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.test_user3.id

  role_ids = [
    keycloak_role.realm_role_rnp.id
  ]
}

resource "keycloak_user" "test_user4" {
  realm_id   = data.keycloak_realm.realm.id
  username   = "test4"
  enabled    = true
  first_name = "Test4"
  last_name  = "PRACTITIONER-MD"
  initial_password {
    value     = var.test_user_password
    temporary = false
  }
}

resource "keycloak_user_roles" "test_user4_roles" {
  realm_id = data.keycloak_realm.realm.id
  user_id  = keycloak_user.test_user4.id

  role_ids = [
    keycloak_role.realm_role_moa.id,
    keycloak_role.realm_role_md.id
  ]
}


resource "keycloak_group_memberships" "group_members" {
  realm_id = data.keycloak_realm.realm.id
  group_id = keycloak_group.fhir_user_group.id

  members = [
    keycloak_user.user1.username,
    keycloak_user.user2.username,
    keycloak_user.test_user1.username,
    keycloak_user.test_user2.username,
    keycloak_user.test_user3.username,
    keycloak_user.test_user4.username
  ]
}


