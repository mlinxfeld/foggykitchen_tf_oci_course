resource "oci_core_virtual_network" "FoggyKitchenVCN2" {
  depends_on = [oci_identity_policy.FoggyKitchenLPGPolicy2]
  cidr_block = var.VCN-CIDR2
  dns_label = "FoggyKitcheVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenVCN2"
}

