resource "oci_core_local_peering_gateway" "FoggyKitchenHUBLPG2" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenHUBLPG2"
  route_table_id = oci_core_route_table.FoggyKitchenDRG2toRequestorRouteTable.id
}


resource "oci_core_local_peering_gateway" "FoggyKitchenSPOKELPG2" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name = "FoggyKitchenSPOKELPG2"
  peer_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
}

