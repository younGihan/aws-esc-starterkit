resource "meshstack_building_block_definition" "this" {
  metadata = {
    owned_by_workspace = var.owning_workspace_identifier
  }

  spec = {
    display_name          = "AWS ESC Starter Kit"
    description           = "Creates a new project with an AWS European Sovereign Cloud account in the dev, qa or prod landing zone."
    display_name_template = "AWS ESC {{project_name}} ({{landing_zone}})"
    target_type           = "WORKSPACE_LEVEL"
    run_transparency      = true
  }

  version_spec = {
    draft         = var.draft
    deletion_mode = "DELETE"

    # Workspace permissions of the ephemeral API key handed to building block runs.
    permissions = [
      "PROJECT_LIST",
      "PROJECT_SAVE",
      "PROJECT_DELETE",
      "TENANT_LIST",
      "TENANT_SAVE",
      "TENANT_DELETE",
      "PROJECTPRINCIPALROLE_LIST",
      "PROJECTPRINCIPALROLE_SAVE",
      "PROJECTPRINCIPALROLE_DELETE",
    ]

    implementation = {
      terraform = {
        repository_url    = var.repository_url
        repository_path   = var.repository_path
        ref_name          = var.ref_name
        terraform_version = var.terraform_version
        async             = false
      }
    }

    inputs = {
      landing_zone = {
        display_name      = "Landing Zone"
        description       = "Environment of the AWS ESC landing zone the account is created in."
        type              = "SINGLE_SELECT"
        assignment_type   = "USER_INPUT"
        selectable_values = ["dev", "qa", "prod"]
        default_value     = jsonencode("dev")
        display_order     = 1
      }
      project_name = {
        display_name                   = "Project Name"
        description                    = "Lowercase letters, digits and dashes. The landing zone is appended, e.g. 'my-app' becomes 'my-app-dev'."
        type                           = "STRING"
        assignment_type                = "USER_INPUT"
        value_validation_regex         = "^[a-z0-9]([a-z0-9-]{0,25}[a-z0-9])?$"
        validation_regex_error_message = "Use 1-27 lowercase letters, digits and dashes, not starting or ending with a dash."
        display_order                  = 2
      }
      workspace_identifier = {
        display_name    = "Workspace Identifier"
        type            = "STRING"
        assignment_type = "WORKSPACE_IDENTIFIER"
      }
      users = {
        display_name    = "Users"
        type            = "CODE"
        assignment_type = "USER_PERMISSIONS"
      }
      platform_uuid = {
        display_name    = "Platform UUID"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.platform_uuid)
      }
      landing_zone_prefix = {
        display_name    = "Landing Zone Prefix"
        type            = "STRING"
        assignment_type = "STATIC"
        argument        = jsonencode(var.landing_zone_prefix)
      }
    }

    outputs = {
      project_identifier = {
        display_name    = "Project"
        type            = "STRING"
        assignment_type = "NONE"
      }
      aws_account_id = {
        display_name    = "AWS Account ID"
        type            = "STRING"
        assignment_type = "NONE"
      }
      summary = {
        display_name    = "Summary"
        type            = "STRING"
        assignment_type = "SUMMARY"
      }
    }
  }
}
