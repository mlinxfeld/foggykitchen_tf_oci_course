resource "oci_core_security_list" "FoggyKitchenICMPecurityList" {
    provider = "oci.requestor"
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "Foggy KitchenICMPSecurity List"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
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
}
