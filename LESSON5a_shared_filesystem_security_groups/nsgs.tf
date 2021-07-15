# Web NSG
resource "oci_core_network_security_group" "FoggyKitchenWebSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenWebSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Web NSG Egress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# Web NSG Ingress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityIngressGroupRules" {
  for_each = toset(var.webservice_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# SSH NSG
resource "oci_core_network_security_group" "FoggyKitchenSSHSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenSSHSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# SSH NSG Egress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# SSH NSG Ingress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityIngressGroupRules" {
  for_each = toset(var.bastion_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG
resource "oci_core_network_security_group" "FoggyKitchenFSSSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenFSSSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# FSS NSG Ingress TCP Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressTCPGroupRules" {
  for_each = toset(var.fss_ingress_tcp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.WebSubnet-CIDR
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Ingress UDP Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressUDPGroupRules" {
  for_each = toset(var.fss_ingress_udp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "17"
  source                    = var.WebSubnet-CIDR
  source_type               = "CIDR_BLOCK"
  udp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Egress TCP Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressTCPGroupRules" {
  for_each = toset(var.fss_egress_tcp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = var.WebSubnet-CIDR
  destination_type          = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Egress UDP Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressUDPGroupRules" {
  for_each = toset(var.fss_egress_udp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "17"
  destination               = var.WebSubnet-CIDR
  destination_type          = "CIDR_BLOCK"
  udp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}
