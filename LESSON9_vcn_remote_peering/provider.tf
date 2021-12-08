terraform {
  required_version = ">= 0.15.0"
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "= 4.48.0"
    }
  }
}

provider "oci" {
  alias            = "requestor" #oci-region-1 
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region1
}

provider "oci" {
  alias            = "acceptor" #oci-region-2
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region2
}

provider "oci" {
  alias            = "homeregion" #oci-region-1 
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = data.oci_identity_region_subscriptions.home_region_subscriptions.region_subscriptions[0].region_name
}
