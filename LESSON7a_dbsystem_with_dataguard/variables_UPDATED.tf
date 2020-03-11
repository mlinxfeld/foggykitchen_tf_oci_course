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

variable "websubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "lbsubnet-CIDR" {
  default = "10.0.2.0/24"
}

variable "bastionsubnet-CIDR" {
  default = "10.0.3.0/24"
}

variable "fsssubnet-CIDR" {
  default = "10.0.5.0/24"
}


#variable "ADs" {
#  default = ["unja:EU-FRANKFURT-1-AD-1", "unja:EU-FRANKFURT-1-AD-2", "unja:EU-FRANKFURT-1-AD-3"]
#}

variable "Shapes" {
 default = ["VM.Standard.E2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "OsImage" {
  # Oracle-Linux-7.7-2020.02.21-0 in Frankfurt
  default = "Oracle-Linux-7.7-2020.02.21-0"
}

#variable "Images" {
 # Oracle-Linux-7.7-2019.11.12-0 in Frankfurt
# default = ["ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa3bu75jht762mfvwroa2gdck6boqwyktztyu5dfhftcycucyp63ma"]
#}

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

# DBStandbySystem specific 
variable "DBStandbyNodeShape" {
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

variable "DBStandbySystemDisplayName" {
    default = "FoggyKitchenDBStandbySystem"
}

variable "DBNodeDomainName" {
    default = "FoggyKitchenN4.FoggyKitchenVCN.oraclevcn.com"
}

variable "DBNodeHostName" {
    default = "foggydbpri"
}

variable "DBStandbyNodeHostName" {
    default = "foggydbstb"
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
