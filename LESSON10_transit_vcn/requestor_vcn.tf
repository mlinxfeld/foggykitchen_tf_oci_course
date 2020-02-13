resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  provider = oci.requestor
  cidr_block = var.VCN-CIDR
  dns_label = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenVCN"
}
