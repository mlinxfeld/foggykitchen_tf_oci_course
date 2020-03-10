resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  provider = oci.requestor
  cidr_block = var.VCN-CIDR
  dns_label = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenVCN"
}

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "R-ADs" {
  provider = oci.requestor
  compartment_id = var.tenancy_ocid
}

# Gets the Id of a specific OS Images
data "oci_core_images" "R-OSImageLocal" {
  provider = oci.requestor
  #Required
  compartment_id = var.compartment_ocid
  display_name   = var.OsImage
}