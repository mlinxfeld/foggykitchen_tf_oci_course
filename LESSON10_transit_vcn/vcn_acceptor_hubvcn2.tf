resource "oci_core_virtual_network" "FoggyKitchenHUBVCN2" {
  provider = oci.acceptor
  cidr_block = var.VCN-CIDR2
  dns_label = "FKHUBVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenHUBVCN2"
}
