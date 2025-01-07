# Home Region Subscription DataSource
data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# ADs DataSource
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.tenancy_ocid
}

# Images DataSource
data "oci_core_images" "OSImage" {
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

# WebServers Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver_VNIC1_attach" {
  count               = var.ComputeCount
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index % length(data.oci_identity_availability_domains.ADs.availability_domains)], "name") 
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver[count.index].id
}

# WebServers Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver_VNIC1" {
  count   = var.ComputeCount
  vnic_id = data.oci_core_vnic_attachments.FoggyKitchenWebserver_VNIC1_attach[count.index].vnic_attachments.0.vnic_id
}
