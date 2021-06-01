# Gets a list of Availability Domains
data "oci_identity_availability_domains" "A-ADs" {
  provider       = oci.acceptor
  compartment_id = var.tenancy_ocid
}

data "oci_core_images" "A-OSImage" {
  provider                 = oci.acceptor
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.Shape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

data "oci_core_vnic_attachments" "FoggyKitchenDepartamentServer1_VNIC1_attach" {
  provider = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  instance_id = oci_core_instance.FoggyKitchenDepartamentServer1.id
}

data "oci_core_vnic" "FoggyKitchenDepartamentServer1_VNIC1" {
  provider = oci.acceptor
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenDepartamentServer1_VNIC1_attach.vnic_attachments.0.vnic_id
}

data "oci_core_vnic_attachments" "FoggyKitchenDepartamentServer2_VNIC1_attach" {
  provider = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  instance_id = oci_core_instance.FoggyKitchenDepartamentServer2.id
}

data "oci_core_vnic" "FoggyKitchenDepartamentServer2_VNIC1" {
  provider = oci.acceptor
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenDepartamentServer2_VNIC1_attach.vnic_attachments.0.vnic_id
}

data "oci_core_vnic_attachments" "FoggyKitchenHubServer1_VNIC1_attach" {
  provider = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  instance_id = oci_core_instance.FoggyKitchenHubServer1.id
}

data "oci_core_vnic" "FoggyKitchenHubServer1_VNIC1" {
  provider = oci.acceptor
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenHubServer1_VNIC1_attach.vnic_attachments.0.vnic_id
}

