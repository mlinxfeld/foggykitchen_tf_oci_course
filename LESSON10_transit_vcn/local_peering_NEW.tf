resource "oci_core_route_table" "FoggyKitchenHUBLPG1RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name = "FoggyKitchenHUBLPG1RouteTable"
  route_rules {
    cidr_block = var.VCN-CIDR3 # to SPOKEVCN1
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
  }
}

resource "oci_core_local_peering_gateway" "FoggyKitchenHUBLPG1" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenHUBLPG1"
  route_table_id = oci_core_route_table.FoggyKitchenHUBLPG1RouteTable.id
}



resource "oci_core_local_peering_gateway" "FoggyKitchenSPOKELPG1" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN3.id
  display_name = "FoggyKitchenSPOKELPG1"
  peer_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
}



