resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenInternetGateway"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}
