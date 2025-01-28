# Home Region Subscription DataSource
data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# Gets a list of Availability Domains in region2
data "oci_identity_availability_domains" "R2-ADs" {
  provider       = oci.region2
  compartment_id = var.tenancy_ocid
}

# Gets a list of Availability Domains in region1
data "oci_identity_availability_domains" "R1-ADs" {
  provider       = oci.region1
  compartment_id = var.tenancy_ocid
}

# Images DataSource in region2 for BackendServer
data "oci_core_images" "BackendServerImage" {
  provider                 = oci.region2
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.BackendServerShape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Images DataSource in region1 for Webserver
data "oci_core_images" "WebserverImage" {
  provider                 = oci.region1
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.WebserverShape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# Images DataSource in region1 for BastionServer
data "oci_core_images" "BastionImage" {
  provider                 = oci.region1
  compartment_id           = var.compartment_ocid
  operating_system         = var.instance_os
  operating_system_version = var.linux_os_version
  shape                    = var.BastionShape

  filter {
    name   = "display_name"
    values = ["^.*Oracle[^G]*$"]
    regex  = true
  }
}

# WebServers Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver_VNIC1_attach" {
  provider            = oci.region1
  count               = var.ComputeCount
  availability_domain = var.availability_domain_name == "" ? lookup(data.oci_identity_availability_domains.R1-ADs.availability_domains[count.index % length(data.oci_identity_availability_domains.R1-ADs.availability_domains)], "name") : var.availability_domain_name 
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver[count.index].id
}

# WebServers Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver_VNIC1" {
  provider  = oci.region1
  count     = var.ComputeCount
  vnic_id   = data.oci_core_vnic_attachments.FoggyKitchenWebserver_VNIC1_attach[count.index].vnic_attachments.0.vnic_id
}

# BackendServer Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenBackendserver1_VNIC1_attach" {
  provider            = oci.region2
  availability_domain = var.availability_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.R2-ADs.availability_domains[0], "name") : var.availability_domain_name2
  compartment_id      = oci_identity_compartment.ExternalCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenBackendserver1.id
}

# BackendServer Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenBackendserver1_VNIC1" {
  provider = oci.region2
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenBackendserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

# Bastion Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenBastionServer_VNIC1_attach" {
  provider            = oci.region1
  availability_domain = var.availability_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.R1-ADs.availability_domains[0], "name") : var.availability_domain_name2
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenBastionServer.id
}

# Bastion Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenBastionServer_VNIC1" {
  provider = oci.region1
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenBastionServer_VNIC1_attach.vnic_attachments.0.vnic_id
}

# DBNodes DataSource
data "oci_database_db_nodes" "DBNodeList" {
  provider       = oci.region1
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  db_system_id   = oci_database_db_system.FoggyKitchenDBSystem.id
}

# DBNodes Details DataSource
data "oci_database_db_node" "DBNodeDetails" {
  provider   = oci.region1
  db_node_id = lookup(data.oci_database_db_nodes.DBNodeList.db_nodes[0], "id")
}

# DBSystem VNIC1 DataSource
data "oci_core_vnic" "FoggyKitchenDBSystem_VNIC1" {
  provider = oci.region1
  vnic_id  = data.oci_database_db_node.DBNodeDetails.vnic_id
}
