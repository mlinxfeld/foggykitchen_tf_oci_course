resource "oci_core_virtual_network" "FoggyKitchenSpokeVCN4" {
  provider = oci.acceptor
  cidr_block = var.VCN-CIDR4
  dns_label = "FoggyKitchenSpokeVCN4"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenSpokeVCN4"
}
