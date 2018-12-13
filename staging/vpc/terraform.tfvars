terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform.git//vpc?ref=v0.0.1"
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

name                         = "app-staging"
cidr                         = "10.10.0.0/16"
create_database_subnet_group = true
enable_nat_gateway           = true
single_nat_gateway           = true
enable_vpn_gateway           = true
enable_s3_endpoint           = true
enable_dynamodb_endpoint     = true
enable_dhcp_options          = false

azs                 = ["us-west-2a", "us-west-2b", "us-west-2c"]
private_subnets     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
public_subnets      = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
database_subnets    = ["10.10.21.0/24", "10.10.22.0/24", "10.10.23.0/24"]

tags = {
  Name        = "app-staging"
  Environment = "staging"
}