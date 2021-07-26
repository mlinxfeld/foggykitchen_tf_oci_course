# VCN
resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  cidr_block     = var.VCN-CIDR
  dns_label      = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenVCN"
}

# DHCP Options
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions1" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenDHCPOptions1"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["foggykitchen.com"]
  }
}

# Internet Gateway
resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenInternetGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for IGW
resource "oci_core_route_table" "FoggyKitchenRouteTableViaIGW" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenRouteTableViaIGW"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.FoggyKitchenInternetGateway.id
  }
}

# NAT Gateway
resource "oci_core_nat_gateway" "FoggyKitchenNATGateway" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenNATGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for NAT
resource "oci_core_route_table" "FoggyKitchenRouteTableViaNAT" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenRouteTableViaNAT"
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
  }
}

# Security List for HTTP/HTTPS
resource "oci_core_security_list" "FoggyKitchenWebSecurityList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenWebSecurityList"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.webservice_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.VCN-CIDR
  }
}

# Security List for SSH
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.bastion_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.VCN-CIDR
  }
}

# SQLNet Security List
resource "oci_core_security_list" "FoggyKitchenSQLNetSecurityList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "Foggy Kitchen SQLNet Security List"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.sqlnet_ports
    content {
      protocol = "6"
      source   = "0.0.0.0/0"
      tcp_options {
        max = ingress_security_rules.value
        min = ingress_security_rules.value
      }
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.VCN-CIDR
  }
}

# Security List for ICMP in VCN
resource "oci_core_security_list" "FoggyKitchenICMPecurityList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "Foggy KitchenICMPSecurity List"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id

  egress_security_rules {
    protocol    = "6"
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

# WebSubnet (private)
resource "oci_core_subnet" "FoggyKitchenWebSubnet" {
  cidr_block                 = var.WebSubnet-CIDR
  display_name               = "FoggyKitchenWebSubnet"
  dns_label                  = "FoggyKitchenN2"
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id             = oci_core_route_table.FoggyKitchenRouteTableViaNAT.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenWebSecurityList.id, oci_core_security_list.FoggyKitchenSSHSecurityList.id]
  prohibit_public_ip_on_vnic = true
}

# LoadBalancer Subnet (public)
resource "oci_core_subnet" "FoggyKitchenLBSubnet" {
  cidr_block        = var.LBSubnet-CIDR
  display_name      = "FoggyKitchenLBSubnet"
  dns_label         = "FoggyKitchenN1"
  compartment_id    = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenWebSecurityList.id]
}

# Bastion Subnet (public)
resource "oci_core_subnet" "FoggyKitchenBastionSubnet" {
  cidr_block        = var.BastionSubnet-CIDR
  display_name      = "FoggyKitchenBastionSubnet"
  dns_label         = "FoggyKitchenN3"
  compartment_id    = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList.id]
}

# DBSystem Subnet (private)
resource "oci_core_subnet" "FoggyKitchenDBSubnet" {
  cidr_block                 = var.DBSystemSubnet-CIDR
  display_name               = "FoggyKitchenDBSubnet"
  dns_label                  = "FoggyKitchenN4"
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id             = oci_core_route_table.FoggyKitchenLPG1RouteTable.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenSSHSecurityList.id, oci_core_security_list.FoggyKitchenSQLNetSecurityList.id]
  prohibit_public_ip_on_vnic = true
}


# VCN2
resource "oci_core_virtual_network" "FoggyKitchenVCN2" {
  depends_on     = [oci_identity_policy.FoggyKitchenLPGPolicy2]
  cidr_block     = var.VCN-CIDR2
  dns_label      = "FoggyKitcheVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenVCN2"
}

# DHCP Options in VCN2
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions2" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenDHCPOptions1"

  // required
  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  // optional
  options {
    type                = "SearchDomain"
    search_domain_names = ["foggykitchen.com"]
  }
}

# Security List for SSH in VCN2 
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList2" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  ingress_security_rules {
    tcp_options {
      max = 22
      min = 22
    }
    protocol = "6"
    source   = "0.0.0.0/0"
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.VCN-CIDR2
  }

}

# Security List for ICMP in VCN2 
resource "oci_core_security_list" "FoggyKitchenICMPecurityList2" {
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenICMPSecurityList2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id

  egress_security_rules {
    protocol    = "6"
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

# Backend Subnet (private) in VCN2
resource "oci_core_subnet" "FoggyKitchenBackendSubnet" {
  cidr_block                 = var.BackendSubnet-CIDR
  display_name               = "FoggyKitchenBackendSubnet"
  dns_label                  = "FoggyKitchenN5"
  compartment_id             = oci_identity_compartment.ExternalCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN2.id
  route_table_id             = oci_core_route_table.FoggyKitchenLPG2RouteTable.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions2.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenSSHSecurityList2.id, oci_core_security_list.FoggyKitchenICMPecurityList2.id]
  prohibit_public_ip_on_vnic = true
}
