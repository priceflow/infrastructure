# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
terragrunt = {
  iam_role = "arn:aws:iam::720031351651:role/priceflow"
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt        = true
      bucket         = "priceflow-staging-terraform-state"
      key            = "${path_relative_to_include()}/terraform.tfstate"
      region         = "us-west-2"
      dynamodb_table = "terraform-locks"
    }
  }
  # Configure root level variables that all resources can inherit
  terraform {
    extra_arguments "bucket" {
      commands = ["${get_terraform_commands_that_need_vars()}"]
      optional_var_files = [
          "${get_tfvars_dir()}/${find_in_parent_folders("account.tfvars", "ignore")}",
          "${get_tfvars_dir()}/${find_in_parent_folders("db.tfvars", "ignore")}"
      ]
    }
  }
}
