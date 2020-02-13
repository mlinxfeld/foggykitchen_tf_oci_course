resource "oci_core_internet_gateway" "ExternalInternetGateway1" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "ExternalInternetGateway1"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
}

resource "oci_core_internet_gateway" "ExternalInternetGateway2" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "ExternalInternetGateway2"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
}