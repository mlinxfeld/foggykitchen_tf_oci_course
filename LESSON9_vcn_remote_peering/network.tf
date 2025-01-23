# VCN
resource "oci_core_virtual_network" "FoggyKitchenVCN" {
  provider       = oci.region1
  cidr_block     = var.VCN-CIDR
  dns_label      = "FoggyKitchenVCN"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenVCN"
}

# VCN2
resource "oci_core_virtual_network" "FoggyKitchenVCN2" {
  provider       = oci.region2
  cidr_block     = var.VCN-CIDR2
  dns_label      = "FoggyKitcheVCN2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenVCN2"
}

# DHCP Options for VCN1
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions1" {
  provider       = oci.region1
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

# DHCP Options for VCN2
resource "oci_core_dhcp_options" "FoggyKitchenDhcpOptions2" {
  provider       = oci.region2
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

# Internet Gateway
resource "oci_core_internet_gateway" "FoggyKitchenInternetGateway" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenInternetGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for IGW
resource "oci_core_route_table" "FoggyKitchenRouteTableViaIGW" {
  provider       = oci.region1
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
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenNATGateway"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id
}

# Route Table for NAT and DRG1
resource "oci_core_route_table" "FoggyKitchenRouteTableViaNATandDRG1" {
  provider       = oci.region1
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
}

# Route Table via DRG2
resource "oci_core_route_table" "FoggyKitchenRouteTableViaDRG2" {
  provider       = oci.region2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN2.id
  display_name   = "FoggyKitchenRouteTableViaDRG2"

  route_rules {
    destination       = var.VCN-CIDR
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG2.id
  }
}

# Security List for HTTP/HTTPS in VCN
resource "oci_core_security_list" "FoggyKitchenWebSecurityList" {
  provider       = oci.region1
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

# Security List for SSH in VCN
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList"
  vcn_id         = oci_core_virtual_network.FoggyKitchenVCN.id

  egress_security_rules {
    protocol    = "6"
    destination = "0.0.0.0/0"
  }

  dynamic "ingress_security_rules" {
    for_each = var.ssh_ports
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

# SQLNet Security List in VCN
resource "oci_core_security_list" "FoggyKitchenSQLNetSecurityList" {
  provider       = oci.region1
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

# Security List for SSH in VCN2
resource "oci_core_security_list" "FoggyKitchenSSHSecurityList2" {
  provider       = oci.region2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name   = "FoggyKitchenSSHSecurityList2"
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
    source   = var.DBSystemSubnet-CIDR
  }

  ingress_security_rules {
    protocol = "6"
    source   = var.VCN-CIDR2
  }
}

# LoadBalancer Subnet (public) in VCN
resource "oci_core_subnet" "FoggyKitchenLBSubnet" {
  provider          = oci.region1
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
  provider                   = oci.region1
  cidr_block                 = var.PrivateSubnet-CIDR
  display_name               = "FoggyKitchenWebSubnet"
  dns_label                  = "FoggyKitchenN2"
  compartment_id             = oci_identity_compartment.FoggyKitchenCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN.id
  route_table_id             = oci_core_route_table.FoggyKitchenRouteTableViaNATandDRG1.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions1.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenWebSecurityList.id, oci_core_security_list.FoggyKitchenSSHSecurityList.id]
  prohibit_public_ip_on_vnic = true
}

# Bastion Subnet (public) in VCN
resource "oci_core_subnet" "FoggyKitchenBastionSubnet" {
  provider          = oci.region1
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
  provider                   = oci.region1
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

# Backend Subnet (private) in VCN2
resource "oci_core_subnet" "FoggyKitchenBackendSubnet" {
  provider                   = oci.region2
  cidr_block                 = var.BackendSubnet-CIDR
  display_name               = "FoggyKitchenBackendSubnet"
  dns_label                  = "FoggyKitchenN5"
  prohibit_public_ip_on_vnic = true
  compartment_id             = oci_identity_compartment.ExternalCompartment.id
  vcn_id                     = oci_core_virtual_network.FoggyKitchenVCN2.id
  route_table_id             = oci_core_route_table.FoggyKitchenRouteTableViaDRG2.id
  dhcp_options_id            = oci_core_dhcp_options.FoggyKitchenDhcpOptions2.id
  security_list_ids          = [oci_core_security_list.FoggyKitchenSSHSecurityList2.id]
}


