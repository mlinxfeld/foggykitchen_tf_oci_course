resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityIngressGroupRules" {
    for_each = toset(var.webservice_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityIngressGroupRules" {
    for_each = toset(var.bastion_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}