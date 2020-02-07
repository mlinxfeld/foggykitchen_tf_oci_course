resource "oci_core_drg" "FoggyKitchenDRG1" {
  depends_on     = ["oci_identity_policy.FoggyKitchenRequestorPolicy", "oci_identity_user_group_membership.FoggyKitchenRequestorUserGroupMembership"]
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
}

resource "oci_core_drg_attachment" "FoggyKitchenDRG1Attachment" {
  depends_on = ["oci_identity_policy.FoggyKitchenRequestorPolicy", "oci_identity_user_group_membership.FoggyKitchenRequestorUserGroupMembership"]
  provider   = oci.requestor
  drg_id     = oci_core_drg.FoggyKitchenDRG1.id
  vcn_id     = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_remote_peering_connection" "FoggyKitchenRPC1" {
  depends_on       = ["oci_identity_policy.FoggyKitchenRequestorPolicy", "oci_identity_user_group_membership.FoggyKitchenRequestorUserGroupMembership"]
  provider         = oci.requestor
  compartment_id   = oci_identity_compartment.FoggyKitchenCompartment.id
  drg_id           = oci_core_drg.FoggyKitchenDRG1.id
  display_name     = "FoggyKitchenRPC1"
  peer_id          = oci_core_remote_peering_connection.FoggyKitchenRPC2.id
  peer_region_name = var.region2
}
