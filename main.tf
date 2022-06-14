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

provider "tfe" {
  hostname = var.hostname
}

data "tfe_organization" "drift_testing_org" {
  name  = "drift-testing-org"
}

data "tfe_organization_membership" "user" {
  organization  = tfe_organization.drift_testing_org.name
  email = var.user_email
}

resource "tfe_workspace" "managed_workspace" {
  count        = 5
  organization = tfe_organization.drift_testing_org.name
  auto_apply   = true
  name         = "managed-workspace-${count.index}"
}
