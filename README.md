# kc-idp-poc

A Proof of Concept for Keycloak acting principally as an external IdP for use with FHIR Server.

A demo of terraform configuration with external IdP and custom mapping for clients that need varying claims from the user accounts... showing the concept of health care provider claims vs. patient claims, and the right authentication for the right client - whether its for PHR or say an EMR.

## Keyclaok Goals

- realm level default claims mapping for common claims.
- IdP custom claims mapping for spcific IdP integrations
- Claims mappings for specific clients based on type of client (i.e. provider or patient-facing)
- Use of terraform to manage the configurations.
- Basic User roles as adjunct claims both realm-level roles.
- Showcase ability for subject to appear as provider for provider clients and patient for patient appsm, respecting privacy of claims not appropriate, through client-level attributes mappings.
