output "building_block_definition_uuid" {
  value       = meshstack_building_block_definition.this.metadata.uuid
  description = "UUID of the AWS ESC starter kit building block definition."
}

output "building_block_definition_version" {
  value       = meshstack_building_block_definition.this.version_latest
  description = "Latest version of the building block definition, including drafts."
}
