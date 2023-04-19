check "check_workspace_name" {
  assert {
    condition     = tfe_workspace.managed_workspace.name == "managed-workspace"
    error_message = "Workspace ${tfe_workspace.managed_workspace.name} does not have the correct name"
  }
}
