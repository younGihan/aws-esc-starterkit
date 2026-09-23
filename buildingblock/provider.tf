terraform {
  required_version = ">= 1.9.0"

  required_providers {
    meshstack = {
      source  = "meshcloud/meshstack"
      version = ">= 0.24.0"
    }
  }
}

# Credentials are injected by the meshStack building block runner as an ephemeral API key
# via MESHSTACK_ENDPOINT, MESHSTACK_API_KEY and MESHSTACK_API_SECRET.
provider "meshstack" {}
