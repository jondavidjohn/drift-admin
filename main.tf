terraform {
  required_providers {
    tfe = {
      version  = "~> 0.26.0"
    }
  }
}

variable "hostname" {
  type = string
}

variable "org_name" {
  type = string
}

provider "tfe" {
  hostname = var.hostname
}

resource "tfe_workspace" "managed_workspace" {
  count        = 6
  organization = var.org_name
  auto_apply   = true
  name         = "managed-workspace-${count.index}"
}

check "check_workspace_name" {
  assert {
    condition     = tfe_workspace.managed_workspace[0].name == "managed-workspace-0"
    error_message = "Workspace ${tfe_workspace.managed_workspace[0].name} does not have the correct name"
  }
}
