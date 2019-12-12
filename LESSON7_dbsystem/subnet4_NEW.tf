resource "oci_core_subnet" "FoggyKitchenDBSubnet" {
  cidr_block = "10.0.4.0/24"
  display_name = "FoggyKitchenDBSubnet"
  dns_label = "FoggyKitchenN4"
  prohibit_public_ip_on_vnic = true
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id = oci_core_route_table.FoggyKitchenRouteTableViaNAT.id
  dhcp_options_id = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList.id,oci_core_security_list.FoggyKitchenSQLNetSecurityList.id]
}

