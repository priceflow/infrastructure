terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-rds.git//?ref=v0.0.7"
  }

  dependencies {
    paths = ["../vpc", "../bastion"]
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

remote_bucket  = "priceflow-production-terraform-state"
name           = "app-production-rds"
instance_class = "db.t2.medium"

tags = {
  Name        = "app-production-rds"
  Environment = "production"
}
