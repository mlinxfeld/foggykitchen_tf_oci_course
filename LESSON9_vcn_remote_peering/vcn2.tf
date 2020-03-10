resource "oci_core_virtual_network" "FoggyKitchenVCN2" {
  provider = oci.acceptor
  cidr_block = var.VCN-CIDR2
  dns_label = "FoggyKitcheVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenVCN2"
}

# Gets a list of Availability Domains
data "oci_identity_availability_domains" "A-ADs" {
  provider = oci.acceptor
  compartment_id = var.tenancy_ocid
}

# Gets the Id of a specific OS Images
data "oci_core_images" "A-OSImageLocal" {
  provider = oci.acceptor
  #Required
  compartment_id = var.compartment_ocid
  display_name   = var.OsImage
}