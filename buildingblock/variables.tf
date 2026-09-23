variable "workspace_identifier" {
  type        = string
  description = "Identifier of the meshStack workspace the project is created in. Assigned by meshStack."
}

variable "project_name" {
  type        = string
  description = "Name of the project. Combined with the landing zone to form the project identifier, e.g. 'my-app' becomes 'my-app-dev'."

  validation {
    condition     = can(regex("^[a-z0-9]([a-z0-9-]{0,25}[a-z0-9])?$", var.project_name))
    error_message = "Project name must be 1-27 characters of lowercase letters, digits and dashes, and must not start or end with a dash."
  }
}

variable "landing_zone" {
  type        = string
  description = "Environment of the AWS ESC landing zone the account is created in."

  validation {
    condition     = contains(["dev", "qa", "prod"], var.landing_zone)
    error_message = "Landing zone must be one of 'dev', 'qa' or 'prod'."
  }
}

variable "platform_uuid" {
  type        = string
  description = "UUID of the AWS ESC meshPlatform. Set statically by the backplane."
}

variable "landing_zone_prefix" {
  type        = string
  description = "Prefix of the landing zone identifiers, e.g. 'aws-esc' for 'aws-esc-dev'. Set statically by the backplane."
}

variable "users" {
  type = list(object({
    username = string
    roles    = list(string)
  }))
  default     = []
  description = "Workspace users and their workspace roles. Assigned by meshStack via USER_PERMISSIONS."
}
