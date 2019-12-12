resource "oci_core_local_peering_gateway" "FoggyKitchenLPG1" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name = "LPG1"
  peer_id = oci_core_local_peering_gateway.FoggyKitchenLPG2.id
}

resource "oci_core_route_table" "FoggyKitchenLPG1RouteTable" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name = "FoggyKitchenLPG1RouteTable"
  route_rules {
    cidr_block = var.VCN-CIDR2
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenLPG1.id
  }
  route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
    }
}

