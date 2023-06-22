# Keycloak for Proof of Concept

This is a Docker build that uses Keycloak 18.0.2 legacy edition.

<https://github.com/bradhead/keycloak-extensions-for-fhir#readme>

## How to build

```shell
docker compose up
```

This installs a non-production docker instance of keycloak.

### Realm loaded

The docker compose execution, loads the realm:

```code
./realm/realm.json
```

If you are setting this up on production-grade server, you would import this, or create is manually, but also create the primary terraform client to get started.

It loads a realm which has a client 'terraform'. That client is then configured manually to be a service account with admin privileges in order for terraform scripts to run. The scripts need the client secret.

## Steps to configure the terraform client

1. Login as admin.
2. Select the realm.
3. Go to Clients -> terraform, or create this client and set to Confidential.
4. Under Terraform client, click on 'Credentials' tab.
5. Tap 'Regenerate Secret' button and copy the secret and save it for the terraform script configurations.
6. Under the Terraform client, tap on 'Service Account Roles'
7. Under Client Roles, scroll on the list and select 'realm management'
8. Under 'Available Roles' options, select 'realm admin' to add that to Assigned Roles.

