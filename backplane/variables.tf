variable "owning_workspace_identifier" {
  type        = string
  default     = "aws-platformteam"
  description = "Identifier of the meshStack workspace that owns the building block definition."
}

variable "platform_uuid" {
  type        = string
  default     = "8ff202b9-227a-4475-925f-cc99e5f00118"
  description = "UUID of the AWS ESC meshPlatform (see platform-integration)."
}

variable "landing_zone_prefix" {
  type        = string
  default     = "aws-esc"
  description = "Prefix of the landing zone identifiers created by platform-integration, e.g. 'aws-esc' for 'aws-esc-dev'."
}

variable "repository_url" {
  type        = string
  description = "Git repository URL containing the building block Terraform code (e.g. 'https://github.com/my-org/demo-meshstack.git')."
}

variable "repository_path" {
  type        = string
  default     = "aws-esc-starterkit/buildingblock"
  description = "Path to the building block Terraform code within the repository."
}

variable "ref_name" {
  type        = string
  default     = "main"
  description = "Git branch, tag or commit of the building block code."
}

variable "terraform_version" {
  type        = string
  default     = "1.9.0"
  description = "Terraform/OpenTofu version the building block runner uses."
}

variable "draft" {
  type        = bool
  default     = true
  description = "Keep the building block definition version as a draft. Set to false to release it."
}
