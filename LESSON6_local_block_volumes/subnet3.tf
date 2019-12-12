resource "oci_core_subnet" "FoggyKitchenBastionSubnet" {
  cidr_block = "10.0.3.0/24"
  display_name = "FoggyKitchenBastionSubnet"
  dns_label = "FoggyKitchenN3"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList.id]
}


