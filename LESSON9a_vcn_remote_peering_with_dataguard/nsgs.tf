# Web NSG (Region1)
resource "oci_core_network_security_group" "FoggyKitchenWebSecurityGroup" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenWebSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# SSH NSG (Region1)
resource "oci_core_network_security_group" "FoggyKitchenSSHSecurityGroup" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenSSHSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# FSS NSG (Region1)
resource "oci_core_network_security_group" "FoggyKitchenFSSSecurityGroup" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenFSSSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# DB NSG (Region1)
resource "oci_core_network_security_group" "FoggyKitchenDBSystemSecurityGroup" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenDBSystemSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# SSH NSG (Region2)
resource "oci_core_network_security_group" "FoggyKitchenSSHSecurityGroup2" {
  provider       = oci.region2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityGroup2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
}

# DB NSG (Region2)
resource "oci_core_network_security_group" "FoggyKitchenDBSystemSecurityGroup2" {
  provider       = oci.region2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenDBSystemSecurityGroup2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
}

# FSS NSG Ingress TCP Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressTCPGroupRules" {
  provider = oci.region1
  for_each = toset(var.fss_ingress_tcp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.PrivateSubnet-CIDR
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Ingress UDP Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityIngressUDPGroupRules" {
  provider = oci.region1
  for_each = toset(var.fss_ingress_udp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "17"
  source                    = var.PrivateSubnet-CIDR
  source_type               = "CIDR_BLOCK"
  udp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Egress TCP Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressTCPGroupRules" {
  provider = oci.region1
  for_each = toset(var.fss_egress_tcp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = var.PrivateSubnet-CIDR
  destination_type          = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# FSS NSG Egress UDP Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenFSSSecurityEgressUDPGroupRules" {
  provider = oci.region1
  for_each = toset(var.fss_egress_udp_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenFSSSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "17"
  destination               = var.PrivateSubnet-CIDR
  destination_type          = "CIDR_BLOCK"
  udp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# Web NSG Ingress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityEgressGroupRule" {
  provider                  = oci.region1
  network_security_group_id = oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# Web NSG Egress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebSecurityIngressGroupRule" {
  provider = oci.region1
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

# SSH NSG Egress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityEgressGroupRule" {
  provider                  = oci.region1
  network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# SSH NSG Ingress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityIngressGroupRules" {
  provider = oci.region1
  for_each = toset(var.ssh_ports)

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

# DB NSG Egress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityEgressGroupRule" {
  provider                  = oci.region1
  network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# DB NSG Ingress Rule (Region1)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityIngressGroupRules" {
  provider = oci.region1
  for_each = toset(var.sqlnet_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id
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


# SSH NSG Egress Rule (Region2)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityEgressGroupRule2" {
  provider                  = oci.region2
  network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup2.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# SSH NSG Ingress Rule (Region2)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenSSHSecurityIngressGroupRules2" {
  provider = oci.region2
  for_each = toset(var.ssh_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenSSHSecurityGroup2.id
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

# DB NSG Egress Rule (Region2)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityEgressGroupRule2" {
  provider                  = oci.region2
  network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup2.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# DB NSG Ingress Rule (Region2)
resource "oci_core_network_security_group_security_rule" "FoggyKitchenDBSystemSecurityIngressGroupRules2" {
  provider = oci.region2
  for_each = toset(var.sqlnet_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup2.id
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
