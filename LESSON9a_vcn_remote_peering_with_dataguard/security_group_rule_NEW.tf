resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorFSSSecurityIngressTCPGroupRules" {
    provider = oci.requestor
    for_each = toset(var.fss_ingress_tcp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorFSSSecurityGroup.id
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

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorFSSSecurityIngressUDPGroupRules" {
    provider = oci.requestor
    for_each = toset(var.fss_ingress_udp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorFSSSecurityGroup.id
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

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorFSSSecurityEgressTCPGroupRules" {
    provider = oci.requestor
    for_each = toset(var.fss_egress_tcp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorFSSSecurityGroup.id
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

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorFSSSecurityEgressUDPGroupRules" {
    provider = oci.requestor
    for_each = toset(var.fss_egress_udp_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorFSSSecurityGroup.id
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


resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorWebSecurityEgressGroupRule" {
    provider = oci.requestor
    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorWebSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorWebSecurityIngressGroupRules" {
    provider = oci.requestor
    for_each = toset(var.webservice_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorWebSecurityGroup.id
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

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorSSHSecurityEgressGroupRule" {
    provider = oci.requestor   
    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorSSHSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorSSHSecurityIngressGroupRules" {
    provider = oci.requestor
    for_each = toset(var.bastion_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorSSHSecurityGroup.id
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


resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorDBSystemSecurityEgressGroupRule" {
    provider = oci.requestor
    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorDBSystemSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenRequestorDBSystemSecurityIngressGroupRules" {
    provider = oci.requestor
    for_each = toset(var.sqlnet_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenRequestorDBSystemSecurityGroup.id
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



resource "oci_core_network_security_group_security_rule" "FoggyKitchenAcceptorSSHSecurityEgressGroupRule" {
    provider = oci.acceptor   
    network_security_group_id = oci_core_network_security_group.FoggyKitchenAcceptorSSHSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenAcceptorSSHSecurityIngressGroupRules" {
    provider = oci.acceptor
    for_each = toset(var.bastion_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenAcceptorSSHSecurityGroup.id
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


resource "oci_core_network_security_group_security_rule" "FoggyKitchenAcceptorDBSystemSecurityEgressGroupRule" {
    provider = oci.acceptor   
    network_security_group_id = oci_core_network_security_group.FoggyKitchenAcceptorDBSystemSecurityGroup.id
    direction = "EGRESS"
    protocol = "6"
    destination = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "FoggyKitchenAcceptorDBSystemSecurityIngressGroupRules" {
    provider = oci.acceptor   
    for_each = toset(var.sqlnet_ports)

    network_security_group_id = oci_core_network_security_group.FoggyKitchenAcceptorDBSystemSecurityGroup.id
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