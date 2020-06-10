resource "oci_core_network_security_group" "FoggyKitchenRequestorWebSecurityGroup" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenRequestorWebSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenRequestorSSHSecurityGroup" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenRequestorSSHSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenRequestorFSSSecurityGroup" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenRequestorFSSSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenRequestorDBSystemSecurityGroup" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "FoggyKitchenRequestorDBSystemSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
}

resource "oci_core_network_security_group" "FoggyKitchenAcceptorSSHSecurityGroup" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenAcceptorSSHSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
}

resource "oci_core_network_security_group" "FoggyKitchenAcceptorDBSystemSecurityGroup" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenAcceptorDBSystemSecurityGroup"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
}