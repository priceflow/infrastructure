terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-rds.git//?ref=v0.0.9"
  }

  dependencies {
    paths = ["../vpc"]
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

remote_bucket  = "priceflow-test-terraform-state"
name           = "app-test-rds"
rds_snapshot   = "app-test-rds"
instance_class = "db.t2.small"

tags = {
  Name        = "app-test-rds"
  Environment = "test"
}
