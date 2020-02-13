resource "oci_core_route_table" "FoggyKitchenSPOKELPG1RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  display_name = "FoggyKitchenSPOKELPG1RouteTable"
  route_rules {
    cidr_block = var.VCN-CIDR2 # to HUBVCN
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG1.id
  }
}

resource "oci_core_subnet" "FoggyKitchenSpokeSubnet1" {
  provider = oci.acceptor
  cidr_block = "172.16.1.0/24"
  display_name = "FoggyKitchenSpokeSubnet1"
  dns_label = "FoggyKitcheN6"
  prohibit_public_ip_on_vnic = true
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  route_table_id = oci_core_route_table.FoggyKitchenSPOKELPG1RouteTable.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions2.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList2.id,oci_core_security_list.FoggyKitchenICMPecurityList2.id]
}

