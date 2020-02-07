resource "oci_core_instance" "FoggyKitchenBackendserver1" {
  provider = "oci.requestor"
  availability_domain = var.ADs2[0]
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenBackendServer1"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.FoggyKitchenBackendSubnet.id
  source_details {
    source_type = "image"
    source_id   = var.Images[0]
  }
  metadata = {
      ssh_authorized_keys = file(var.public_key_oci)
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.FoggyKitchenBackendSubnet.id
     assign_public_ip = false 
  }
}

data "oci_core_vnic_attachments" "FoggyKitchenBackendserver1_VNIC1_attach" {
  availability_domain = var.ADs2[0]
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  instance_id = oci_core_instance.FoggyKitchenBackendserver1.id
}

data "oci_core_vnic" "FoggyKitchenBackendserver1_VNIC1" {
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenBackendserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "FoggyKitchenBackendserver1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenBackendserver1_VNIC1.private_ip_address]
}
