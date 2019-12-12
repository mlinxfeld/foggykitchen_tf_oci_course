resource "oci_core_local_peering_gateway" "FoggyKitchenLPG2" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name = "LPG2"
#  peer_id = oci_core_local_peering_gateway.FoggyKitchenLPG1.id
}

resource "oci_core_route_table" "FoggyKitchenLPG2RouteTable" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name = "FoggyKitchenLPG2RouteTable"
  route_rules {
    cidr_block = var.VCN-CIDR
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenLPG2.id
  }
}

