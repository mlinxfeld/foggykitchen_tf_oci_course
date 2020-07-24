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


variable "Shapes" {
 default = ["VM.Standard.E2.1","VM.Standard.E2.1.Micro","VM.Standard2.1","VM.Standard.E2.1","VM.Standard.E2.2"]
}

variable "OsImage" {
  default = "Oracle-Linux-7.8-2020.05.26-0"
}

variable "webservice_ports" {
  default = ["80","443"]
}

variable "bastion_ports" {
  default = ["22"]
}

variable "sqlnet_ports" {
  default = ["1521"]
}

variable "fss_ingress_tcp_ports" {
  default = ["111","2048","2049","2050"]
}

variable "fss_ingress_udp_ports" {
  default = ["111","2048"]
}

variable "fss_egress_tcp_ports" {
  default = ["111","2048","2049","2050"]
}

variable "fss_egress_udp_ports" {
  default = ["111"]
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
    default = "ENTERPRISE_EDITION"
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

variable "DBHomeDisplayName" {
    default = "FoggyDBHome"
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
