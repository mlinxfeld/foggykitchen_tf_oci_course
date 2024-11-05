variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}

variable "availablity_domain_name" {
  default = ""
}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "WebSubnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "LBSubnet-CIDR" {
  default = "10.0.2.0/24"
}

variable "BastionSubnet-CIDR" {
  default = "10.0.3.0/24"
}

variable "DBSystemSubnet-CIDR" {
  default = "10.0.4.0/24"
}

variable "MountTargetIPAddress" {
  default = "10.0.1.26"
}

variable "Shape" {
  default = "VM.Standard.E4.Flex"
}

variable "FlexShapeOCPUS" {
  default = 1
}

variable "FlexShapeMemory" {
  default = 2
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "8"
}

variable "webservice_ports" {
  default = ["80", "443"]
}

variable "bastion_ports" {
  default = ["22"]
}

variable "lb_shape" {
  default = "flexible"
}

variable "flex_lb_min_shape" {
  default = 10
}

variable "flex_lb_max_shape" {
  default = 100
}

variable "sqlnet_ports" {
  default = [1521]
}

variable "DBNodeShape" {
  default = "VM.Standard2.1"
}

variable "CPUCoreCount" {
  default = 1
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
  default = "TFPDB1"
}

variable "DataStorageSizeInGB" {
  default = 256
}

variable "LicenseModel" {
  default = "LICENSE_INCLUDED"
}

variable "NodeCount" {
  default = 1
}

variable "volume_size_in_gbs" {
  default = 100
}

# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
}

# Checks if is using Flexible Compute Shapes
locals {
  is_flexible_shape    = contains(local.compute_flexible_shapes, var.Shape)
  is_flexible_lb_shape = var.lb_shape == "flexible" ? true : false
}
