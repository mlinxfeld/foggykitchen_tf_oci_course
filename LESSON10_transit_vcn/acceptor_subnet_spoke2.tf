resource "oci_core_route_table" "FoggyKitchenSPOKELPG2RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name = "FoggyKitchenSPOKELPG2RouteTable"
  
  route_rules {
    cidr_block = var.VCN-CIDR2 # to HUBVCN
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    cidr_block = var.VCN-CIDR # to FRA infra
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    cidr_block = "0.0.0.0/0" # to Internet
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

}

resource "oci_core_subnet" "FoggyKitchenSpokeSubnet2" {
  provider = oci.acceptor
  cidr_block = "172.16.2.0/24"
  display_name = "FoggyKitchenSpokeSubnet2"
  dns_label = "FoggyKitcheN7"
  prohibit_public_ip_on_vnic = true
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  route_table_id = oci_core_route_table.FoggyKitchenSPOKELPG2RouteTable.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions4.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList4.id,oci_core_security_list.FoggyKitchenICMPecurityList4.id]
}

