resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressTCPGroupRules" {
    for_each = toset(var.fss_ingress_tcp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
    direction = "INGRESS"
    protocol = "6"
    source = var.websubnet-CIDR
    source_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressUDPGroupRules" {
    for_each = toset(var.fss_ingress_udp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
    direction = "INGRESS"
    protocol = "17"
    source = var.websubnet-CIDR
    source_type = "CIDR_BLOCK"
    udp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressTCPGroupRules" {
    for_each = toset(var.fss_egress_tcp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = var.websubnet-CIDR
    destination_type = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressUDPGroupRules" {
    for_each = toset(var.fss_egress_udp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
    direction = "EGRESS"
    protocol = "17"
    destination = var.websubnet-CIDR
    destination_type = "CIDR_BLOCK"
    udp_options {
        destination_port_range {
            max = each.value
            min = each.value
        }
    }
}


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


resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityEgressGroupRule" {
    network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityIngressGroupRules" {
    for_each = toset(var.sqlnet_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id
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