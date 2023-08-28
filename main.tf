terraform {
  required_providers {
    tfe = {
      version  = "0.43.0"
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
  organization = var.org_name
  auto_apply   = false
  name         = "managed-workspace"
  tag_names    = ["some:tag"]

  lifecycle {
    postcondition {
      condition     = self.name == "managed-workspace"
      error_message = "This workspace does not have the correct name"
    }
  }
}
