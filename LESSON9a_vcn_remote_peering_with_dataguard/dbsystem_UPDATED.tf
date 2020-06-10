resource "oci_database_db_system" "FoggyKitchenDBSystem" {
  provider = oci.requestor
  availability_domain = lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  cpu_core_count = var.CPUCoreCount
  database_edition = var.DBEdition
  db_home {
    database {
      admin_password = var.DBAdminPassword
      db_name = var.DBName
      character_set = var.CharacterSet
      ncharacter_set = var.NCharacterSet
      db_workload = var.DBWorkload
      pdb_name = var.PDBName
    }
    db_version = var.DBVersion
    display_name = var.DBDisplayName
  }
  disk_redundancy = var.DBDiskRedundancy
  shape = var.DBNodeShape
  subnet_id = oci_core_subnet.FoggyKitchenDBSubnet.id
  ssh_public_keys = [file(var.public_key_oci)]
  display_name = var.DBSystemDisplayName
  domain = var.DBNodeDomainName
  hostname = var.DBNodeHostName
  nsg_ids = [oci_core_network_security_group.FoggyKitchenRequestorDBSystemSecurityGroup.id]
  data_storage_percentage = "40"
  data_storage_size_in_gb = var.DataStorageSizeInGB
  license_model = var.LicenseModel
  node_count = var.NodeCount
}

#data "oci_database_db_homes" "primarydb_home" {
#  provider       = oci.requestor
#  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
#  db_system_id   = oci_database_db_system.FoggyKitchenDBSystem.id

 # filter {
 #   name   = "display_name"
 #   values = [var.DBHomeDisplayName]
 # }
#}

#data "oci_database_databases" "primarydb" {
#  provider       = oci.requestor
#  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
#  db_home_id     = "${data.oci_database_db_homes.primarydb_home.db_homes.0.db_home_id}"
#}

resource "oci_database_data_guard_association" "FoggyKitchenDBSystemStandby" {
    provider = oci.requestor
    creation_type = "NewDbSystem"
    database_admin_password = var.DBAdminPassword
    database_id = oci_database_db_system.FoggyKitchenDBSystem.db_home[0].database[0].id
 #   database_id = data.oci_database_databases.primarydb.databases.0.id
    protection_mode = "MAXIMUM_PERFORMANCE"
    transport_type = "ASYNC"
    delete_standby_db_home_on_delete = "true"

    availability_domain = lookup(data.oci_identity_availability_domains.A-ADs.availability_domains[0], "name")
    display_name = var.DBStandbySystemDisplayName
    hostname = var.DBStandbyNodeHostName
    nsg_ids = [oci_core_network_security_group.FoggyKitchenAcceptorDBSystemSecurityGroup.id]
    shape = var.DBStandbyNodeShape
    subnet_id = oci_core_subnet.FoggyKitchenBackendSubnet.id
}

data "oci_database_db_nodes" "DBNodeList" {
  provider = oci.requestor
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  db_system_id = oci_database_db_system.FoggyKitchenDBSystem.id
}

data "oci_database_db_node" "DBNodeDetails" {
  provider = oci.requestor
  db_node_id = lookup(data.oci_database_db_nodes.DBNodeList.db_nodes[0], "id")
}

data "oci_core_vnic" "FoggyKitchenDBSystem_VNIC1" {
  provider = oci.requestor
  vnic_id = data.oci_database_db_node.DBNodeDetails.vnic_id
}

output "FoggyKitchenDBServer_PrivateIP" {
   value = [data.oci_core_vnic.FoggyKitchenDBSystem_VNIC1.private_ip_address]
}
