# kc-demo

A demo of terraform configuration with external IdP and custom mapping for clients that need varying claims from the user accounts... showing the concept of health care provider claims vs. patient claims, and the right authentication for the right client - whether its for PHR or say an EMR.

Goals:
- realm level default claims mapping for common claims.
- IdP custom claims mapping for spcific IdP integrations
- Claims mappings for specific clients based on type of clent.
- Use of terraform to manage the configurations.
- Basic User roles as adjunct claims both realm-level and client level roles.

