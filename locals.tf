locals {
  project = {
    "fem-eci-project" = {
      description = "Example description of project"
    }
  }

  workspace = {
    "fem-eci-tfe" = {
      description         = "Example automation workspace for Terraform Cloud resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-tfe"
    }

    "fem-eci-github" = {
      description         = "Example automation workspace for GitHub resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-github"
    }

    "fem-eci-aws-network" = {
      description         = "Automation for AWS network resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-aws-network"

# config workspaces 
      variables = [
        {
          category = "terraform"
          hcl      = true # array parsing 
          key      = "azs"
          value    = jsonencode(["us-west-2a", "us-west-2b"])
        },
        {
          category = "terraform"
          key      = "cidr"
          value    = "10.0.0.0/16"
        },
        {
          category = "terraform"
          key      = "name"
          value    = "fem-eci"
        },
      ]
    }

# need to be specifc with name of cluster 
    "fem-eci-aws-cluster" = {
      description         = "Automation for AWS cluster resources."
      execution_mode      = "remote"
      project_id          = module.project["fem-eci-project"].id
      vcs_repo_identifier = "${var.github_organization_name}/fem-eci-terraform-aws-cluster"

      variables = [
        {
          category = "terraform"
          key      = "domain"
          value    = "quynhdao.dev" 
        },
        {
          category = "terraform"
          key      = "environment"
          value    = "prod"
        },
        {
          category = "terraform"
          key      = "name"
          value    = "fem-eci-quynhdao" # name of cluster, need to be unique 
        },
        {
          category = "terraform"
          key      = "vpc_name"
          value    = "fem-eci" # 
        },
      ]
    }
  }
}
