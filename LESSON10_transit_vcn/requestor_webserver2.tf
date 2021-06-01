resource "oci_core_instance" "FoggyKitchenWebserver2" {
  provider = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name 
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenWebServer2"
  shape = var.Shape
  dynamic "shape_config" {
    for_each = local.is_flexible_shape ? [1] : []
    content {
      memory_in_gbs = var.FlexShapeMemory
      ocpus = var.FlexShapeOCPUS
    }
  }
  fault_domain = "FAULT-DOMAIN-2"
  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_images.R-OSImage.images[0], "id")
  }
  metadata = {
      ssh_authorized_keys = tls_private_key.public_private_key_pair.public_key_openssh
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.FoggyKitchenWebSubnet.id
     assign_public_ip = false
  }
}

