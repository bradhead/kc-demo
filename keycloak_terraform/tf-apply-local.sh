#!bin/sh
terraform workspace select local_kc

terraform apply --var-file configuration-local.tfvars


