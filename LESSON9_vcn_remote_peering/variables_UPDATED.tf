variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "private_key_oci" {}
variable "public_key_oci" {}

variable "region1" {
  default = "eu-frankfurt-1"
}

variable "region2" {
  default = "eu-amsterdam-1"
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "VCN-CIDR2" {
  default = "192.168.0.0/16"
}

variable "ADs1" {
  default = ["unja:EU-FRANKFURT-1-AD-1", "unja:EU-FRANKFURT-1-AD-2", "unja:EU-FRANKFURT-1-AD-3"]
}

variable "ADs2" {
  default = ["unja:EU-AMSTERDAM-1-AD-1"]
}

variable "Shapes" {
 default = ["VM.Standard.E2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "Images1" {
 # Oracle-Linux-7.7-2020.01.28-0 in Frankfurt
 default = ["ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa4xluwijh66fts4g42iw7gnixntcmns73ei3hwt2j7lihmswkrada"]
}

variable "Images2" {
 # Oracle-Linux-7.7-2020.01.28-0 in Amsterdam
 default = ["ocid1.image.oc1.eu-amsterdam-1.aaaaaaaan5tbzuvtyd5lwxj66zxc7vzmpvs5axpcxyhoicbr6yxgw2s7nqvq"]
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
