resource "oci_core_subnet" "FoggyKitchenWebSubnet" {
  cidr_block = var.Subnet-CIDR
  display_name = "FoggyKitchenWebSubnet"
  dns_label = "FoggyKitchenN1"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSecurityList.id]
}


