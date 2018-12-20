terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-ftp.git//?ref=v0.0.2"
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

name                         = "app-staging-ftp"
ssh_user                     = "ubuntu"
key_name                     = "ccg"
instance_type                = "t3.small"
ami                          = "ami-0bbe6b35405ecebdb"     # ubuntu 18.04
tags = {
  Name        = "app-staging-ftp"
  Environment = "staging"
}