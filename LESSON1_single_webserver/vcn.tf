resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  cidr_blocks = split(",", var.VCN-CIDRs)
  dns_label = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenVCN"
}

