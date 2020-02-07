resource "oci_core_security_list" "FoggyKitchenICMPecurityList2" {
    provider = "oci.acceptor"
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    display_name = "FoggyKitchenICMPSecurityList2"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN2.id
    
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
