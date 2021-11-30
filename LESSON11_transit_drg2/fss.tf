# Mount Target

resource "oci_file_storage_mount_target" "FoggyKitchenMountTarget" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  subnet_id           = oci_core_subnet.FoggyKitchenWebSubnet.id
  ip_address          = var.MountTargetIPAddress
  display_name        = "FoggyKitchenMountTarget"
}

# Export Set

resource "oci_file_storage_export_set" "FoggyKitchenExportset" {
  provider        = oci.requestor
  mount_target_id = oci_file_storage_mount_target.FoggyKitchenMountTarget.id
  display_name    = "FoggyKitchenExportset"
}

# FileSystem

resource "oci_file_storage_file_system" "FoggyKitchenFilesystem" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name        = "FoggyKitchenFilesystem"
}

# Export

resource "oci_file_storage_export" "FoggyKitchenExport" {
  provider       = oci.requestor
  export_set_id  = oci_file_storage_mount_target.FoggyKitchenMountTarget.export_set_id
  file_system_id = oci_file_storage_file_system.FoggyKitchenFilesystem.id
  path           = "/sharedfs"
}


