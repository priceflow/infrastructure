terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-postgrest.git//?ref=v0.0.60"
  }

  dependencies {
    paths = ["../vpc", "../rds"]
  }

  # Include all settings from the root terraform.tfvars file
  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

remote_bucket                = "priceflow-production-terraform-state"
name                         = "app-production-postgrest"
s3_path                      = "s3://priceflow-production/postgrest/.env"
ssh_user                     = "ubuntu"
key_name                     = "production"
stage                        = "production"
instance_type                = "t3.small"
ami                          = "ami-036f2557c8e4540aa"
hosted_zone_id               = "Z2Q7LCZASLCSOC"
domain_name                  = "priceflow-prod.com"
num_instances                = "2"
tags = {
  Name        = "app-production-postgrest"
  Environment = "production"
}
