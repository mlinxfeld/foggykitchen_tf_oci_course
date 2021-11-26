# DBSystem
resource "oci_database_db_system" "FoggyKitchenDBSystem" {
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  cpu_core_count      = var.CPUCoreCount
  database_edition    = var.DBEdition
  db_home {
    database {
      admin_password = var.DBAdminPassword
      db_name        = var.DBName
      character_set  = var.CharacterSet
      ncharacter_set = var.NCharacterSet
      db_workload    = var.DBWorkload
      pdb_name       = var.PDBName
    }
    db_version   = var.DBVersion
    display_name = var.DBHomeDisplayName
  }
  disk_redundancy         = var.DBDiskRedundancy
  shape                   = var.DBNodeShape
  subnet_id               = oci_core_subnet.FoggyKitchenDBSubnet.id
  ssh_public_keys         = [tls_private_key.public_private_key_pair.public_key_openssh]
  display_name            = var.DBSystemDisplayName
  domain                  = var.DBNodeDomainName
  hostname                = var.DBNodeHostName
  nsg_ids                 = [oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id]
  data_storage_percentage = "40"
  data_storage_size_in_gb = var.DataStorageSizeInGB
  license_model           = var.LicenseModel
  node_count              = var.NodeCount
}

# Standby DBSystem 
resource "oci_database_data_guard_association" "FoggyKitchenDBSystemStandby" {
  creation_type                    = "NewDbSystem"
  database_admin_password          = var.DBAdminPassword
  database_id                      = data.oci_database_databases.primarydb.databases.0.id
  protection_mode                  = "MAXIMUM_PERFORMANCE"
  transport_type                   = "ASYNC"
  delete_standby_db_home_on_delete = "true"

  availability_domain = var.availablity_domain_name2 == "" ? lookup(data.oci_identity_availability_domains.ADs.availability_domains[0], "name") : var.availablity_domain_name2
  display_name        = var.DBStandbySystemDisplayName
  hostname            = var.DBStandbyNodeHostName
  nsg_ids             = [oci_core_network_security_group.FoggyKitchenDBSystemSecurityGroup.id]
  shape               = var.DBStandbyNodeShape
  subnet_id           = oci_core_subnet.FoggyKitchenDBSubnet.id
}

