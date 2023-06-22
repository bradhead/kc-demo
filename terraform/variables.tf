variable "keycloak_environment" {
  type = object({
    realm              = optional(string, "health")
    realm_display_name = optional(string, "Smart on FHIR Realm")
    custom_audience    = optional(string, "fhir-rs")
    base_url           = optional(string, "http://localhost:8080")
  })
  description = "Keycloak configuration environment"
}

variable "keycloak_terraform_client" {
  type = object({
    id     = string
    secret = string
  })
  sensitive   = true
  description = "The keycloak client and secret used by Terraform to create resources"
}

variable "client_app1" {
  type = object({
    id              = optional(string, "swiss-app")
    valid_redirects = list(string)
    web_origins     = list(string)
    base_url        = string
    login_theme     = optional(string, "keycloak")

  })
  description = "Provider App configuration"
}

variable "client_app2" {
  type = object({
    id              = optional(string, "swiss-app2")
    valid_redirects = list(string)
    web_origins     = list(string)
    base_url        = string
    login_theme     = optional(string, "keycloak")

  })
  description = "Patient App configuration"
}

variable "test_user_password" {
  type = string
}


