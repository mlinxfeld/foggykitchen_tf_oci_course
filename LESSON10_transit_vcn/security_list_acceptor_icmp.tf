resource "oci_core_security_list" "FoggyKitchenICMPecurityList2" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenICMPSecurityList2"
    vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }
}

resource "oci_core_security_list" "FoggyKitchenICMPecurityList3" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenICMPSecurityList3"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR2
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR4
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }
}

resource "oci_core_security_list" "FoggyKitchenICMPecurityList4" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenICMPSecurityList4"
    vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR2
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }

    ingress_security_rules {
      protocol  = 1
      source    = var.VCN-CIDR3
      stateless = true
      icmp_options {
        type = 3
        code = 4
      }
    }
}
