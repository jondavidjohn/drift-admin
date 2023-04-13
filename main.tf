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

  lifecycle {
    postcondition {
      condition     = self.name == "managed-workspace-${count.index}"
      error_message = "This workspace does not have the correct name"
    }
  }
}

check "check_workspace_count" {
  assert {
    condition = length(tfe_workspace.managed_workspace) == 6
    error_message = "We have 6 managed workspaces"
  }
}
