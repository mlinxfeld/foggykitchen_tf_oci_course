resource "oci_core_subnet" "FoggyKitchenSpokeSubnet1" {
  provider = oci.acceptor
  cidr_block = "172.16.1.0/24"
  display_name = "FoggyKitchenSpokeSubnet1"
  dns_label = "FoggyKitcheN6"
  #prohibit_public_ip_on_vnic = true
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  route_table_id = oci_core_route_table.FoggyKitchenSPOKELPG1RouteTable.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions3.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList3.id,oci_core_security_list.FoggyKitchenICMPecurityList3.id]
}

