terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.38.0"
    }
  }
}

provider "tfe" {
  hostname = var.hostname
  token = var.token
}

data "tfe_organization" "org" {
  name = var.organization
}

resource "tfe_workspace" "default" {
  count                         = 10
  organization                  = data.tfe_organization.org.name
  name                          = format("test-workspace-%s", count.index)
  terraform_version             = "latest"
  execution_mode                = "remote"
  auto_apply                    = false
  allow_destroy_plan            = true
  queue_all_runs                = true
  speculative_enabled           = true
  structured_run_output_enabled = true
  vcs_repo {
    branch             = "main"
    identifier         = "iborysiuk/poc-tfc-sandbox"
    oauth_token_id     = var.oauth_token_id
    ingress_submodules = true
  }
  tag_names = ["new-tag"]
}

# -----
variable "organization" {
  default = "iborysiuk-sandbox"
  type = string
}

variable "hostname" {
  default = "app.terraform.io" ### Default hostname
  type = string
}

variable "token" {
  type = string 
}

variable "oauth_token_id" {
  type = string
}
