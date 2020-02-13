resource "oci_core_security_list" "FoggyKitchenSQLNetSecurityList" {
    provider = oci.requestor
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    display_name = "Foggy Kitchen SQLNet Security List"
    vcn_id = oci_core_virtual_network.FoggyKitchenVCN.id
    
    egress_security_rules {
        protocol = "6"
        destination = "0.0.0.0/0"
    }
    
    dynamic "ingress_security_rules" {
    for_each = var.sqlnet_ports
    content {
        protocol = "6"
        source = "0.0.0.0/0"
        tcp_options {
            max = ingress_security_rules.value
            min = ingress_security_rules.value
            }
        }
    }

    ingress_security_rules {
        protocol = "6"
        source = var.VCN-CIDR
    }
}
