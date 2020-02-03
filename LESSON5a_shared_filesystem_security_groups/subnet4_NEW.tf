resource "oci_core_subnet" "FoggyKitchenFSSSubnet" {
  cidr_block = var.fsssubnet-CIDR
  display_name = "FoggyKitchenFSSSubnet"
  dns_label = "FoggyKitchenN5"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
}


