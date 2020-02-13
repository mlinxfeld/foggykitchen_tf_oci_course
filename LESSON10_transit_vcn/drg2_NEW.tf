resource "oci_core_drg" "FoggyKitchenDRG2" {
  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy, oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership]
  provider       = oci.acceptor
  display_name   = "FoggyKitchenDRG2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
}

resource "oci_core_route_table" "FoggyKitchenDRG2RouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenDRG2RouteTable"

  route_rules {
    destination       = var.VCN-CIDR3
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR4
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
  }

}

resource "oci_core_drg_attachment" "FoggyKitchenDRG2Attachment" {
  depends_on = [oci_identity_policy.FoggyKitchenAcceptorPolicy, oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership]
  provider   = oci.acceptor
  drg_id     = oci_core_drg.FoggyKitchenDRG2.id
  vcn_id     = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  route_table_id = oci_core_route_table.FoggyKitchenDRG2RouteTable.id
}

resource "oci_core_remote_peering_connection" "FoggyKitchenRPC2" {
  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy, oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership]
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  drg_id         = oci_core_drg.FoggyKitchenDRG2.id
  display_name   = "FoggyKitchenRPC2"
}