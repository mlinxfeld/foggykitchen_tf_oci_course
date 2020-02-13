resource "oci_core_instance" "FoggyKitchenHubServer1" {
  provider = oci.acceptor
  availability_domain = var.ADs2[0]
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  display_name = "FoggyKitchenHubServer1"
  shape = var.Shapes[0]
  subnet_id = oci_core_subnet.FoggyKitchenHubSubnet.id
  source_details {
    source_type = "image"
    source_id   = var.Images2[0]
  }
  metadata = {
      ssh_authorized_keys = file(var.public_key_oci)
  }
  create_vnic_details {
     subnet_id = oci_core_subnet.FoggyKitchenHubSubnet.id
#     assign_public_ip = false 
  }
}

data "oci_core_vnic_attachments" "FoggyKitchenHubServer1_VNIC1_attach" {
  provider = oci.acceptor
  availability_domain = var.ADs2[0]
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  instance_id = oci_core_instance.FoggyKitchenHubServer1.id
}

data "oci_core_vnic" "FoggyKitchenHubServer1_VNIC1" {
  provider = oci.acceptor
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenHubServer1_VNIC1_attach.vnic_attachments.0.vnic_id
}

output "FoggyKitchenHubServer1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenHubServer1_VNIC1.private_ip_address]
}

output "FoggyKitchenHubServer1_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenHubServer1_VNIC1.public_ip_address]
}
