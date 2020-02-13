resource "oci_core_virtual_network" "FoggyKitchenSpokeVCN3" {
  provider = oci.acceptor
  cidr_block = var.VCN-CIDR3
  dns_label = "FKSpokeVCN3"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenSpokeVCN3"
}
