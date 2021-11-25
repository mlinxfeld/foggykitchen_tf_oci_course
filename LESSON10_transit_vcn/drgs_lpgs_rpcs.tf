# DRG1 for VCN
resource "oci_core_drg" "FoggyKitchenDRG1" {
  depends_on     = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider       = oci.requestor
  display_name   = "FoggyKitchenDRG1"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
}

# DRG1 Attachment with VCN
resource "oci_core_drg_attachment" "FoggyKitchenDRG1Attachment" {
  depends_on = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider   = oci.requestor
  drg_id     = oci_core_drg.FoggyKitchenDRG1.id
  vcn_id     = oci_core_virtual_network.FoggyKitchenVCN.id
}

# RPC1 for DRG1
resource "oci_core_remote_peering_connection" "FoggyKitchenRPC1" {
  depends_on       = [oci_identity_policy.FoggyKitchenRequestorPolicy]
  provider         = oci.requestor
  compartment_id   = oci_identity_compartment.FoggyKitchenCompartment.id
  drg_id           = oci_core_drg.FoggyKitchenDRG1.id
  display_name     = "FoggyKitchenRPC1"
  peer_id          = oci_core_remote_peering_connection.FoggyKitchenRPC2.id
  peer_region_name = var.region2
}

# DRG2 for VCN
resource "oci_core_drg" "FoggyKitchenDRG2" {
  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy]
  provider       = oci.acceptor
  display_name   = "FoggyKitchenDRG2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
}

# DRG2 Attachment with VCN
resource "oci_core_drg_attachment" "FoggyKitchenDRG2Attachment" {
  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy]
  provider       = oci.acceptor
  drg_id         = oci_core_drg.FoggyKitchenDRG2.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  route_table_id = oci_core_route_table.FoggyKitchenDRG2RouteTable.id
}

# RPC2 for DRG2
resource "oci_core_remote_peering_connection" "FoggyKitchenRPC2" {
  depends_on     = [oci_identity_policy.FoggyKitchenAcceptorPolicy]
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  drg_id         = oci_core_drg.FoggyKitchenDRG2.id
  display_name   = "FoggyKitchenRPC2"
}

# HUBLPG1
resource "oci_core_local_peering_gateway" "FoggyKitchenHUBLPG1" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name   = "FoggyKitchenHUBLPG1"
  route_table_id = oci_core_route_table.FoggyKitchenHUBLPGRouteTable.id
}

# SPOKELPG1
resource "oci_core_local_peering_gateway" "FoggyKitchenSPOKELPG1" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  display_name   = "FoggyKitchenSPOKELPG1"
  peer_id        = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
}

# HUBLPG2
resource "oci_core_local_peering_gateway" "FoggyKitchenHUBLPG2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name   = "FoggyKitchenHUBLPG2"
  route_table_id = oci_core_route_table.FoggyKitchenHUBLPGRouteTable.id
}

# SPOKELPG1
resource "oci_core_local_peering_gateway" "FoggyKitchenSPOKELPG2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name   = "FoggyKitchenSPOKELPG2"
  peer_id        = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
}
