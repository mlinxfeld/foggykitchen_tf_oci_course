# Home Region Subscription DataSource
data "oci_identity_region_subscriptions" "home_region_subscriptions" {
  tenancy_id = var.tenancy_ocid

  filter {
    name   = "is_home_region"
    values = [true]
  }
}

# Gets a list of Availability Domains in Acceptor region
data "oci_identity_availability_domains" "A-ADs" {
  provider       = oci.acceptor
  compartment_id = var.tenancy_ocid
}


# Gets a list of Availability Domains in Requestor region
data "oci_identity_availability_domains" "R-ADs" {
  provider       = oci.requestor
  compartment_id = var.tenancy_ocid
}

# Images DataSource in Acceptor region
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

# Images DataSource in Requestor region
data "oci_core_images" "R-OSImage" {
  provider                 = oci.requestor
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

# Bastion Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenBastionServer_VNIC1_attach" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenBastionServer.id
}

# Bastion Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenBastionServer_VNIC1" {
  provider = oci.requestor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenBastionServer_VNIC1_attach.vnic_attachments.0.vnic_id
}

# WebServer1 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver1_VNIC1_attach" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver1.id
}

# WebServer1 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver1_VNIC1" {
  provider = oci.requestor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenWebserver1_VNIC1_attach.vnic_attachments.0.vnic_id
}

# WebServer2 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenWebserver2_VNIC1_attach" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenWebserver2.id
}

# WebServer2 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenWebserver2_VNIC1" {
  provider = oci.requestor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenWebserver2_VNIC1_attach.vnic_attachments.0.vnic_id
}

# DepartamentServer1 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenDepartamentServer1_VNIC1_attach" {
  provider            = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id      = oci_identity_compartment.ExternalCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenDepartamentServer1.id
}

# DepartamentServer1 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenDepartamentServer1_VNIC1" {
  provider = oci.acceptor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenDepartamentServer1_VNIC1_attach.vnic_attachments.0.vnic_id
}

# DepartamentServer2 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenDepartamentServer2_VNIC1_attach" {
  provider            = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id      = oci_identity_compartment.ExternalCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenDepartamentServer2.id
}

# DepartamentServer2 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenDepartamentServer2_VNIC1" {
  provider = oci.acceptor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenDepartamentServer2_VNIC1_attach.vnic_attachments.0.vnic_id
}

# HubServer1 Compute VNIC Attachment DataSource
data "oci_core_vnic_attachments" "FoggyKitchenHubServer1_VNIC1_attach" {
  provider            = oci.acceptor
  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name") : var.availablity_domain_name2
  compartment_id      = oci_identity_compartment.ExternalCompartment.id
  instance_id         = oci_core_instance.FoggyKitchenHubServer1.id
}

# HubServer1 Compute VNIC DataSource
data "oci_core_vnic" "FoggyKitchenHubServer1_VNIC1" {
  provider = oci.acceptor
  vnic_id  = data.oci_core_vnic_attachments.FoggyKitchenHubServer1_VNIC1_attach.vnic_attachments.0.vnic_id
}

# DBNodes DataSource
data "oci_database_db_nodes" "DBNodeList" {
  provider       = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  db_system_id   = oci_database_db_system.FoggyKitchenDBSystem.id
}

# DBNodes Details DataSource
data "oci_database_db_node" "DBNodeDetails" {
  provider   = oci.requestor
  db_node_id = lookup(data.oci_database_db_nodes.DBNodeList.db_nodes[0], "id")
}

# DBSystem VNIC1 DataSource
data "oci_core_vnic" "FoggyKitchenDBSystem_VNIC1" {
  provider = oci.requestor
  vnic_id  = data.oci_database_db_node.DBNodeDetails.vnic_id
}
