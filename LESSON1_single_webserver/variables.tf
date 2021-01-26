variable "tenancy_ocid" {}
#variable "user_ocid" {}
#variable "fingerprint" {}
#variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "availablity_domain_name" {}

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
}

variable "Subnet-CIDR" {
  default = "10.0.1.0/24"
}

variable "Shape" {
 default = "VM.Standard.E2.1"
}

variable "instance_os" {
  default = "Oracle Linux"
}

variable "linux_os_version" {
  default = "7.8"
}

variable "service_ports" {
  default = [80,443,22]
}

