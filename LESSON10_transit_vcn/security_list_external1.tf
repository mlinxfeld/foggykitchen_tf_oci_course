resource "oci_core_security_list" "FoggyKitchenSSHSecurityList2" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenSSHSecurityList2"
    vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
    
    egress_security_rules {
	protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
        tcp_options {
          max = 22
          min = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR2
    }
    
}

resource "oci_core_security_list" "FoggyKitchenSSHSecurityList3" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenSSHSecurityList3"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
    
    egress_security_rules {
    protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
        tcp_options {
          max = 22
          min = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR3
    }
    
}

resource "oci_core_security_list" "FoggyKitchenSSHSecurityList4" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenSSHSecurityList4"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
    
    egress_security_rules {
    protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
        tcp_options {
          max = 22
          min = 22
        }
        protocol = "6"
        source = "0.0.0.0/0"
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR4
    }
    
}