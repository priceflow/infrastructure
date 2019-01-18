terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-bastion.git//?ref=v0.0.28"
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
name                         = "app-production-bastion"
ssh_user                     = "ubuntu"
key_name                     = "production"
instance_type                = "t3.small"
ami                          = "ami-0bbe6b35405ecebdb"     # ubuntu 18.04
tags = {
  Name        = "app-production-bastion"
  Environment = "production"
}
