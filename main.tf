terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.38.0"
    }
  }
}

provider "tfe" {}


resource "tfe_workspace" "default" {
  count                         = 10
  organization                  = "iborysiuk-sandbox"
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
    oauth_token_id     = "ot-Ji1Ut1azvF83jyhs"
    ingress_submodules = true
  }
  tag_names = ["new-tag"]
}
