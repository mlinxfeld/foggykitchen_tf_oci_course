resource "oci_core_route_table" "FoggyKitchenRouteTableViaDRG2" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
    display_name = "FoggyKitchenRouteTableViaDRG2"

    route_rules {
        destination       = var.VCN-CIDR
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_drg.FoggyKitchenDRG2.id
    }
}

