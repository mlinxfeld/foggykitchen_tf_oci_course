terraform {
  required_version = ">= 0.15.0"
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">= 6.21.0"
    }
  }
}

# General Provider 
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

