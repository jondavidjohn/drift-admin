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

data "tfe_organization" "drift_testing_org" {
  name  = var.org_name
}

resource "tfe_workspace" "managed_workspace" {
  count        = 5
  organization = data.tfe_organization.drift_testing_org.name
  auto_apply   = true
  name         = "managed-workspace-${count.index}"
}
