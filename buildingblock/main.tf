locals {
  project_identifier = "${var.project_name}-${var.landing_zone}"

  # Workspace owners and managers administer the project, workspace members get user access.
  project_roles = {
    for user in var.users : user.username => (
      length(setintersection(user.roles, ["Workspace Owner", "Workspace Manager"])) > 0 ? "admin" : "user"
    )
  }
}

resource "meshstack_project" "this" {
  metadata = {
    name               = local.project_identifier
    owned_by_workspace = var.workspace_identifier
  }

  spec = {
    display_name = "${var.project_name} (${upper(var.landing_zone)})"
  }
}

resource "meshstack_project_user_binding" "this" {
  for_each = local.project_roles

  metadata = {
    name = "${var.workspace_identifier}.${local.project_identifier}.${each.key}"
  }

  role_ref = {
    name = each.value
  }

  target_ref = {
    name               = meshstack_project.this.metadata.name
    owned_by_workspace = var.workspace_identifier
  }

  subject = {
    name = each.key
  }
}

resource "meshstack_tenant" "this" {
  metadata = {
    owned_by_workspace = var.workspace_identifier
    owned_by_project   = meshstack_project.this.metadata.name
  }

  spec = {
    platform_ref = {
      uuid = var.platform_uuid
    }

    landing_zone_ref = {
      name = "${var.landing_zone_prefix}-${var.landing_zone}"
    }
  }

  wait_for_completion = true
}
