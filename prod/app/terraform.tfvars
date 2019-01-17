terragrunt = {
  # Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
  # working directory, into a temporary folder, and execute your Terraform commands in that folder.
  terraform {
    source = "git::git@github.com:priceflow/terraform-app.git//?ref=v0.0.40"
  }

  dependencies {
    paths = ["../vpc", "../rds", "../bastion", "../postgrest"]
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
namespace                    = "app"
name                         = "app-production-eb"
stage                        = "production"
zone_id                      = "Z2Q7LCZASLCSOC"
domain_name                  = "priceflow-prod.com"
subject_alternative_names    = ["app.priceflow-prod.com"]
key_name                     = "production"
instance_type                = "t3.small"
autoscale_min                = 1
autoscale_max                = 2
updating_min_in_service      = 0
updating_max_batch           = 1

loadbalancer_type            = "application"
solution_stack_name = "64bit Amazon Linux 2018.03 v2.12.2 running Docker 18.03.1-ce"

