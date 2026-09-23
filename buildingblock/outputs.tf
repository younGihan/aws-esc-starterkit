output "project_identifier" {
  value       = meshstack_project.this.metadata.name
  description = "Identifier of the created meshStack project."
}

output "aws_account_id" {
  value       = meshstack_tenant.this.spec.platform_tenant_id
  description = "ID of the AWS ESC account created for the project."
}

output "summary" {
  value       = <<-EOT
    # AWS ESC Project `${meshstack_project.this.metadata.name}`

    Your project was created in the **${upper(var.landing_zone)}** landing zone.

    | | |
    |---|---|
    | Project | `${meshstack_project.this.metadata.name}` |
    | AWS account ID | `${meshstack_tenant.this.spec.platform_tenant_id}` |
    | Landing zone | `${var.landing_zone_prefix}-${var.landing_zone}` |
  EOT
  description = "Markdown summary shown to the user in meshPanel."
}
