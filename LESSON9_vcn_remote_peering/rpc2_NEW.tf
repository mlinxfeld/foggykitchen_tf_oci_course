resource "oci_core_drg" "FoggyKitchenDRG2" {
  depends_on     = ["oci_identity_policy.FoggyKitchenAcceptorPolicy", "oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership"]
  provider       = "oci.acceptor"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
}

resource "oci_core_drg_attachment" "FoggyKitchenDRG1Attachment" {
  depends_on = ["oci_identity_policy.FoggyKitchenAcceptorPolicy", "oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership"]
  provider   = "oci.acceptor"
  drg_id     = oci_core_drg.FoggyKitchenDRG2.id
  vcn_id     = oci_core_vcn.FoggyKitcheVCN2.id
}

resource "oci_core_remote_peering_connection" "FoggyKitchenRPC2" {
  depends_on     = ["oci_identity_policy.FoggyKitchenAcceptorPolicy", "oci_identity_user_group_membership.FoggyKitchenAcceptorUserGroupMembership"]
  provider       = "oci.acceptor"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  drg_id         = oci_core_drg.FoggyKitchenDRG2.id
  display_name   = "FoggyKitchenRPC2"
}