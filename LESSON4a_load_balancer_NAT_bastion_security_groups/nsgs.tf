# Webservers NSG
resource "oci_core_network_security_group" "FoggyKitchenWebserverSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenWebSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Webserver NSG Egress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebserverSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.FoggyKitchenWebserverSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# Webserver NSG Ingress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenWebserverSecurityIngressGroupRules" {
  for_each = toset(var.webservice_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenWebserverSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.LBSubnet-CIDR # Allow traffic only from the Load Balancer Subnet
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# LoadBalancer NSG
resource "oci_core_network_security_group" "FoggyKitchenLBSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenLBSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# LoadBalancer NSG Egress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenLBSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.FoggyKitchenLBSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# LoadBalancer NSG Ingress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenLBSecurityIngressGroupRules" {
  for_each = toset(var.webservice_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenLBSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    =  "0.0.0.0/0" # Allow traffic from the internet
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

# Bastion NSG
resource "oci_core_network_security_group" "FoggyKitchenBastionSecurityGroup" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenBastionSecurityGroup"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Bastion NSG Egress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenBastionSecurityEgressGroupRule" {
  network_security_group_id = oci_core_network_security_group.FoggyKitchenBastionSecurityGroup.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}

# Bastion NSG Ingress Rules
resource "oci_core_network_security_group_security_rule" "FoggyKitchenBastionSecurityIngressGroupRules" {
  for_each = toset(var.ssh_ports)

  network_security_group_id = oci_core_network_security_group.FoggyKitchenBastionSecurityGroup.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = var.bastion_allowed_ip # Restrict to trusted IPs
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = each.value
      min = each.value
    }
  }
}

