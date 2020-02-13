resource "oci_core_route_table" "FoggyKitchenHUBLPG2RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name = "FoggyKitchenHUBLPG2RouteTable"
  route_rules {
    cidr_block = var.VCN-CIDR4 # to SPOKEVCN2
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
  }
}

resource "oci_core_local_peering_gateway" "FoggyKitchenHUBLPG2" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenHUBLPG2"
  route_table_id = oci_core_route_table.FoggyKitchenHUBLPG2RouteTable.id
}



resource "oci_core_local_peering_gateway" "FoggyKitchenSPOKELPG2" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN4.id
  display_name = "FoggyKitchenSPOKELPG2"
  peer_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
}

