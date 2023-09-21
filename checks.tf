check "check_workspace_name" {
  assert {
    condition     = tfe_workspace.managed_workspace.name == "managed-workspace-update-2"
    error_message = "Workspace ${tfe_workspace.managed_workspace.name} doesn't have the correct name"
  }
}
