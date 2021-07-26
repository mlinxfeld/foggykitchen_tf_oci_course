# LPG1 in VCN
resource "oci_core_local_peering_gateway" "FoggyKitchenLPG1" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "LPG1"
  peer_id        = oci_core_local_peering_gateway.FoggyKitchenLPG2.id
}

# LPG1 route table in VCN 
resource "oci_core_route_table" "FoggyKitchenLPG1RouteTable" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenLPG1RouteTable"
  route_rules {
    destination       = var.VCN-CIDR2
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenLPG1.id
  }
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
  }
}

# LPG2 in VCN2
resource "oci_core_local_peering_gateway" "FoggyKitchenLPG2" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name   = "LPG2"
}

# LPG2 route table in VCN2
resource "oci_core_route_table" "FoggyKitchenLPG2RouteTable" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenLPG2RouteTable"
  route_rules {
    destination       = var.VCN-CIDR
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenLPG2.id
  }
}
