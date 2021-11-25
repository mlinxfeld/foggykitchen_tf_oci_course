# VCN
resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  provider       = oci.requestor
  cidr_block     = var.VCN-CIDR
  dns_label      = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenVCN"
}

# HUBVCN2
resource "oci_core_virtual_network" "FoggyKitchenHUBVCN2" {
  provider       = oci.acceptor
  cidr_block     = var.VCN-CIDR2
  dns_label      = "FKHUBVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenHUBVCN2"
}

# SPOKEVCN3
resource "oci_core_virtual_network" "FoggyKitchenSpokeVCN3" {
  provider       = oci.acceptor
  cidr_block     = var.VCN-CIDR3
  dns_label      = "FKSpokeVCN3"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSpokeVCN3"
}

# SPOKEVCN4
resource "oci_core_virtual_network" "FoggyKitchenSpokeVCN4" {
  provider       = oci.acceptor
  cidr_block     = var.VCN-CIDR4
  dns_label      = "FKSpokeVCN4"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSpokeVCN4"
}

# DHCP Options for VCN1
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions1" {
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
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

# DHCP Options for HUBVCN2
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
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

# DHCP Options for SPOKEVCN3
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions3" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  display_name   = "FoggyKitchenDHCPOptions3"

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

# DHCP Options for SPOKEVCN4
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions4" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name   = "FoggyKitchenDHCPOptions4"

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

# Internet Gateway
resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenInternetGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for IGW
resource "oci_core_route_table" "FoggyKitchenRouteTableViaIGW" {
  provider       = oci.requestor
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
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenNATGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for NAT and DRG1
resource "oci_core_route_table" "FoggyKitchenRouteTableViaNATandDRG1" {
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
  display_name   = "FoggyKitchenRouteTableViaNATandDRG1"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_nat_gateway.FoggyKitchenNATGateway.id
  }

  route_rules {
    destination       = var.VCN-CIDR2
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR3
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR4
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG1.id
  }
}

# External Internet Gateway1
resource "oci_core_internet_gateway" "ExternalInternetGateway1" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "ExternalInternetGateway1"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
}

# External Internet Gateway2
resource "oci_core_internet_gateway" "ExternalInternetGateway2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "ExternalInternetGateway2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
}

# Route Table for HUBVCN2
resource "oci_core_route_table" "FoggyKitchenRouteTableHUBVCN2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name   = "FoggyKitchenRouteTableHUBVCN2"

  route_rules {
    destination       = var.VCN-CIDR
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG2.id
  }

  route_rules {
    destination       = var.VCN-CIDR3
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR4
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
  }
}

# Route Table for DRG2
resource "oci_core_route_table" "FoggyKitchenDRG2RouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name   = "FoggyKitchenDRG2RouteTable"

  route_rules {
    destination       = var.VCN-CIDR3
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR4
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenHUBLPG2.id
  }
}

# Route Table for HUBLPG
resource "oci_core_route_table" "FoggyKitchenHUBLPGRouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name   = "FoggyKitchenHUBLPGRouteTable"

  route_rules {
    destination       = var.VCN-CIDR
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG2.id
  }
}

# Route Table for SPOKELPG
resource "oci_core_route_table" "FoggyKitchenSPOKELPG1RouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  display_name   = "FoggyKitchenSPOKELPG1RouteTable"

  route_rules {
    destination       = var.VCN-CIDR2 # to HUBVCN
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG1.id
  }

  route_rules {
    destination       = var.VCN-CIDR # to FRA infra
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG1.id
  }

  route_rules {
    destination       = "0.0.0.0/0" # to Internet
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ExternalInternetGateway1.id
  }

}

# Route Table for SPOKELPG2
resource "oci_core_route_table" "FoggyKitchenSPOKELPG2RouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name   = "FoggyKitchenSPOKELPG2RouteTable"

  route_rules {
    destination       = var.VCN-CIDR2 # to HUBVCN
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    destination       = var.VCN-CIDR # to FRA infra
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    destination       = "0.0.0.0/0" # to Internet
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.ExternalInternetGateway2.id
  }

}

# Security List for HTTP/HTTPS in VCN
resource "oci_core_security_list" "FoggyKitchenWebSecurityList" {
  provider       = oci.requestor
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

# Security List for ICMP in VCN
resource "oci_core_security_list" "FoggyKitchenICMPecurityList" {
  provider       = oci.requestor
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

# SQLNet Security List in VCN
resource "oci_core_security_list" "FoggyKitchenSQLNetSecurityList" {
  provider       = oci.requestor
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

# Security List for SSH in VCN
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList" {
  provider       = oci.requestor
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

# Security List for ICMP in HUBVCN2
resource "oci_core_security_list" "FoggyKitchenICMPecurityList2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenICMPSecurityList2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id

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

# Security List for ICMP in SPOKEVCN3
resource "oci_core_security_list" "FoggyKitchenICMPecurityList3" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenICMPSecurityList3"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id

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

  ingress_security_rules {
    protocol  = 1
    source    = var.VCN-CIDR2
    stateless = true
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    protocol  = 1
    source    = var.VCN-CIDR4
    stateless = true
    icmp_options {
      type = 3
      code = 4
    }
  }
}

# Security List for ICMP in SPOKEVCN4
resource "oci_core_security_list" "FoggyKitchenICMPecurityList4" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenICMPSecurityList4"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id

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

  ingress_security_rules {
    protocol  = 1
    source    = var.VCN-CIDR2
    stateless = true
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    protocol  = 1
    source    = var.VCN-CIDR3
    stateless = true
    icmp_options {
      type = 3
      code = 4
    }
  }
}

# Security List for SSH in HUBVCN2
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList2" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList2"
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id

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

# Security List for SSH in SPOKEVCN3
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList3" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList3"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id

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
    source   = var.VCN-CIDR3
  }

}

# Security List for SSH in SPOKEVCN4
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList4" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList4"
  vcn_id         = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id

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
    source   = var.VCN-CIDR4
  }

}

# Bastion Subnet (public) in VCN
resource "oci_core_subnet" "FoggyKitchenBastionSubnet" {
  provider          = oci.requestor
  cidr_block        = var.BastionSubnet-CIDR
  display_name      = "FoggyKitchenBastionSubnet"
  dns_label         = "FoggyKitchenN3"
  compartment_id    = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList.id]
}

# DBSystem Subnet (private) in VCN
resource "oci_core_subnet" "FoggyKitchenDBSubnet" {
  provider                   = oci.requestor
  cidr_block                 = var.DBSystemSubnet-CIDR
  display_name               = "FoggyKitchenDBSubnet"
  dns_label                  = "FoggyKitchenN4"
  prohibit_public_ip_on_vnic = true
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id             = oci_core_route_table.FoggyKitchenRouteTableViaNATandDRG1.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenSSHSecurityList.id, oci_core_security_list.FoggyKitchenSQLNetSecurityList.id]
}

# LoadBalancer Subnet (public) in VCN
resource "oci_core_subnet" "FoggyKitchenLBSubnet" {
  provider          = oci.requestor
  cidr_block        = var.LBSubnet-CIDR
  display_name      = "FoggyKitchenLBSubnet"
  dns_label         = "FoggyKitchenN1"
  compartment_id    = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableViaIGW.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids = [oci_core_security_list.FoggyKitchenWebSecurityList.id]
}

# WebSubnet (private) in VCN
resource "oci_core_subnet" "FoggyKitchenWebSubnet" {
  provider                   = oci.requestor
  cidr_block                 = var.WebSubnet-CIDR
  display_name               = "FoggyKitchenWebSubnet"
  dns_label                  = "FoggyKitchenN2"
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id             = oci_core_route_table.FoggyKitchenRouteTableViaNATandDRG1.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenWebSecurityList.id, oci_core_security_list.FoggyKitchenSSHSecurityList.id]
  prohibit_public_ip_on_vnic = true
}

# HubSubnet (public) in HUBVCN
resource "oci_core_subnet" "FoggyKitchenHubSubnet" {
  provider     = oci.acceptor
  cidr_block   = var.HubSubnet-CIDR
  display_name = "FoggyKitchenHubSubnet"
  dns_label    = "FoggyKitchenN5"
  #  prohibit_public_ip_on_vnic = true
  compartment_id    = oci_identity_compartment.ExternalCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  route_table_id    = oci_core_route_table.FoggyKitchenRouteTableHUBVCN2.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions2.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList2.id, oci_core_security_list.FoggyKitchenICMPecurityList2.id]
}

# SpokeSubnet1 (public) in SPOKEVCN3
resource "oci_core_subnet" "FoggyKitchenSpokeSubnet1" {
  provider     = oci.acceptor
  cidr_block   = var.Spoke1Subnet-CIDR
  display_name = "FoggyKitchenSpokeSubnet1"
  dns_label    = "FoggyKitcheN6"
  #prohibit_public_ip_on_vnic = true
  compartment_id    = oci_identity_compartment.ExternalCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  route_table_id    = oci_core_route_table.FoggyKitchenSPOKELPG1RouteTable.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions3.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList3.id, oci_core_security_list.FoggyKitchenICMPecurityList3.id]
}

# SpokeSubnet2 (public) in SPOKEVCN4
resource "oci_core_subnet" "FoggyKitchenSpokeSubnet2" {
  provider     = oci.acceptor
  cidr_block   = var.Spoke2Subnet-CIDR
  display_name = "FoggyKitchenSpokeSubnet2"
  dns_label    = "FoggyKitcheN7"
  #prohibit_public_ip_on_vnic = true
  compartment_id    = oci_identity_compartment.ExternalCompartment.id
  vcn_id            = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  route_table_id    = oci_core_route_table.FoggyKitchenSPOKELPG2RouteTable.id
  dhcp_options_id   = oci_core_dhcp_options.FoggyKitchenDhcpOptions4.id
  security_list_ids = [oci_core_security_list.FoggyKitchenSSHSecurityList4.id, oci_core_security_list.FoggyKitchenICMPecurityList4.id]
}


