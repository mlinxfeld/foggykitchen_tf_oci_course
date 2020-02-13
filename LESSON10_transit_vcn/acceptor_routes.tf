resource "oci_core_route_table" "FoggyKitchenRouteTableViaHUPLPGSandDRG2" {
    provider = oci.acceptor
    compartment_id = oci_identity_compartment.ExternalCompartment.id
    vcn_id = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
    display_name = "FoggyKitchenRouteTableViaDRG2"

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

resource "oci_core_route_table" "FoggyKitchenDRG2RouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenDRG2RouteTable"

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

resource "oci_core_route_table" "FoggyKitchenDRG2toRequestorRouteTable" {
  provider       = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  vcn_id         = oci_core_virtual_network.FoggyKitchenHUBVCN2.id
  display_name = "FoggyKitchenDRG2toRequestorRouteTable"

  route_rules {
    destination       = var.VCN-CIDR
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_drg.FoggyKitchenDRG2.id
  }

}

resource "oci_core_route_table" "FoggyKitchenSPOKELPG1RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN3.id
  display_name = "FoggyKitchenSPOKELPG1RouteTable"
  
  route_rules {
    cidr_block = var.VCN-CIDR2 # to HUBVCN
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG1.id
  }

  route_rules {
    cidr_block = var.VCN-CIDR # to FRA infra
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG1.id
  }

  route_rules {
    cidr_block = "0.0.0.0/0" # to Internet
    network_entity_id = oci_core_internet_gateway.ExternalInternetGateway1.id
  }

}

resource "oci_core_route_table" "FoggyKitchenSPOKELPG2RouteTable" {
  provider = oci.acceptor
  compartment_id = oci_identity_compartment.ExternalCompartment.id 
  vcn_id = oci_core_virtual_network.FoggyKitchenSpokeVCN4.id
  display_name = "FoggyKitchenSPOKELPG2RouteTable"
  
  route_rules {
    cidr_block = var.VCN-CIDR2 # to HUBVCN
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    cidr_block = var.VCN-CIDR # to FRA infra
    network_entity_id = oci_core_local_peering_gateway.FoggyKitchenSPOKELPG2.id
  }

  route_rules {
    cidr_block = "0.0.0.0/0" # to Internet
    network_entity_id = oci_core_internet_gateway.ExternalInternetGateway2.id
  }

}
