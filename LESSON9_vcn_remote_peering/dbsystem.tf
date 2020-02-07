/*resource "oci_database_db_system" "FoggyKitchenDBSystem" {
  provider = oci.requestor
  availability_domain = var.ADs1[1]
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
  data_storage_percentage = "40"
  data_storage_size_in_gb = var.DataStorageSizeInGB
  license_model = var.LicenseModel
  node_count = var.NodeCount
}

data "oci_database_db_nodes" "DBNodeList" {
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  db_system_id = oci_database_db_system.FoggyKitchenDBSystem.id
}

data "oci_database_db_node" "DBNodeDetails" {
  db_node_id = lookup(data.oci_database_db_nodes.DBNodeList.db_nodes[0], "id")
}

data "oci_core_vnic" "FoggyKitchenDBSystem_VNIC1" {
  vnic_id = data.oci_database_db_node.DBNodeDetails.vnic_id
}

output "FoggyKitchenDBServer_PrivateIP" {
   value = [data.oci_core_vnic.FoggyKitchenDBSystem_VNIC1.private_ip_address]
}
*/