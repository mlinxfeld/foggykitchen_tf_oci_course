resource "oci_core_route_table" "FoggyKitchenRouteTableViaIGW" {
    provider  = "oci.requestor"
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
    display_name = "FoggyKitchenRouteTableViaIGW"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type  = "CIDR_BLOCK"
        network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway.id
    }
}
