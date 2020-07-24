variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "private_key_oci" {}
variable "public_key_oci" {}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "VCNname" {
  default = "FoggyKitchenVCN"
}


variable "Shapes" {
 default = ["VM.Standard.E2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "OsImage" {
  default = "Oracle-Linux-7.8-2020.05.26-0"
}


variable "webservice_ports" {
  default = [80,443]
}

variable "bastion_ports" {
  default = [22]
}

variable "sqlnet_ports" {
  default = [1521]
}

# DBSystem specific 
variable "DBNodeShape" {
    default = "VM.Standard2.1"
}

variable "CPUCoreCount" {
    default = "1"
}

variable "DBEdition" {
    default = "STANDARD_EDITION"
}

variable "DBAdminPassword" {
    default = "BEstrO0ng_#11"
}

variable "DBName" {
    default = "FOGGYDB"
}

variable "DBVersion" {
    default = "12.1.0.2"
}

variable "DBDisplayName" {
    default = "FoggyDB"
}

variable "DBDiskRedundancy" {
    default = "HIGH"
}

variable "DBSystemDisplayName" {
    default = "FoggyKitchenDBSystem"
}

variable "DBNodeDomainName" {
    default = "FoggyKitchenN4.FoggyKitchenVCN.oraclevcn.com"
}

variable "DBNodeHostName" {
    default = "foggydbnode"
}

variable "HostUserName" {
    default = "opc"
}

variable "NCharacterSet" {
  default = "AL16UTF16"
}

variable "CharacterSet" {
  default = "AL32UTF8"
}

variable "DBWorkload" {
  default = "OLTP"
}

variable "PDBName" {
  default = "mysla"
}

variable "DataStorageSizeInGB" {
  default = "256"
}

variable "LicenseModel" {
  default = "LICENSE_INCLUDED"
}

variable "NodeCount" {
  default = "1"
}
