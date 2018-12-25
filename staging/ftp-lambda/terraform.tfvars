terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-ftp-lambda.git//?ref=v0.0.8"
  }

  dependencies {
    paths = ["../vpc", "../ftp"]
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

remote_bucket                = "priceflow-staging-terraform-state"
name                         = "ftp-lambda"
app_version                  = "0.0.1"
tags = {
  Name        = "app-staging-ftp-lambda"
  Environment = "staging"
}