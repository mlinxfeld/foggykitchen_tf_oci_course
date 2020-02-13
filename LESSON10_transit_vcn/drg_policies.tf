resource "oci_identity_group" "FoggyKitchenRequestorGroup" {
  provider    = oci.admin
  name        = "FoggyKitchenRequestorGroup"
  description = "FoggyKitchenRequestorGroup"
}

resource "oci_identity_user_group_membership" "FoggyKitchenRequestorUserGroupMembership" {
  provider = oci.admin
  group_id = oci_identity_group.FoggyKitchenRequestorGroup.id
  user_id  = var.user_ocid
}

resource "oci_identity_policy" "FoggyKitchenRequestorPolicy" {
  provider       = oci.admin
  name           = "FoggyKitchenRequestorPolicy"
  description    = "FoggyKitchenRequestorPolicy"
  compartment_id = var.tenancy_ocid

  statements = ["Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage virtual-network-family in compartment ${oci_identity_compartment.FoggyKitchenCompartment.name}",
    "Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage instance-family in compartment ${oci_identity_compartment.FoggyKitchenCompartment.name}",
    "Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage remote-peering-from in compartment ${oci_identity_compartment.FoggyKitchenCompartment.name}",
  ]
}


resource "oci_identity_group" "FoggyKitchenAcceptorGroup" {
  provider    = oci.admin
  name        = "FoggyKitchenAcceptorGroup"
  description = "FoggyKitchenAcceptorGroup"
}

resource "oci_identity_user_group_membership" "FoggyKitchenAcceptorUserGroupMembership" {
  provider = oci.admin
  group_id = oci_identity_group.FoggyKitchenAcceptorGroup.id
  user_id  = var.user_ocid
}

resource "oci_identity_policy" "FoggyKitchenAcceptorPolicy" {
  provider       = oci.admin
  name           = "FoggyKitchenAcceptorPolicy"
  description    = "FoggyKitchenAcceptorPolicy"
  compartment_id = var.tenancy_ocid

  statements = ["Allow group ${oci_identity_group.FoggyKitchenRequestorGroup.name} to manage remote-peering-to in compartment ${oci_identity_compartment.ExternalCompartment.name}",
    "Allow group ${oci_identity_group.FoggyKitchenAcceptorGroup.name} to manage virtual-network-family in compartment ${oci_identity_compartment.ExternalCompartment.name}",
    "Allow group ${oci_identity_group.FoggyKitchenAcceptorGroup.name} to manage instance-family in compartment ${oci_identity_compartment.ExternalCompartment.name}",
  ]
}
