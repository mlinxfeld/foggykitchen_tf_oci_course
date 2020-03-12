resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenNATGateway"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}
