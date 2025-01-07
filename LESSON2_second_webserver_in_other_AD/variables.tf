# OCI Authentication and Configuration Variables

variable "tenancy_ocid" {
  description = "The OCID (Oracle Cloud Identifier) of the tenancy where resources will be created."
}

variable "user_ocid" {
  description = "The OCID of the user executing the OpenTofu scripts for provisioning resources."
}

variable "fingerprint" {
  description = "The fingerprint of the API signing key used for authenticating with OCI."
}

variable "private_key_path" {
  description = "The file path to the private key used for OCI API authentication."
}

variable "compartment_ocid" {
  description = "The OCID of the compartment where resources will be created. This is the parent compartment for the deployment."
}

variable "region" {
  description = "The region where OCI resources will be deployed, such as 'us-ashburn-1' or 'eu-frankfurt-1'."
}

# Availability Domain Configuration

variable "availability_domain_name" {
  description = "The name of the availability domain where resources will be deployed. Leave empty to default to the first available domain."
  default = ""
}

# Networking Variables

variable "VCN-CIDR" {
  default = "10.0.0.0/16"
  description = "CIDR block for the Virtual Cloud Network."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.VCN-CIDR))
    error_message = "VCN-CIDR must be a valid CIDR block."
  }  
}

variable "Subnet-CIDR" {
  default = "10.0.1.0/24"
  description = "CIDR block for the Subnet Network."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.Subnet-CIDR))
    error_message = "Subnet-CIDR must be a valid CIDR block."
  }
}

# Compute Variables

variable "ComputeCount" {
  default = 2
  description = "Number of compute instances to create."
  validation {
    condition     = var.ComputeCount > 0
    error_message = "ComputeCount must be greater than 0."
  }
}

variable "Shape" {
  default = "VM.Standard.E4.Flex"
  description = "Shape for the compute instance."
  validation {
    condition     = contains(["VM.Standard.E3.Flex", "VM.Standard.E4.Flex", "VM.Standard.A1.Flex", "VM.Optimized3.Flex"], var.Shape)
    error_message = "Shape must be one of the supported shapes: VM.Standard.E3.Flex, VM.Standard.E4.Flex, VM.Standard.A1.Flex, or VM.Optimized3.Flex."
  }
}

variable "FlexShapeOCPUS" {
  description = "The number of OCPUs (Oracle CPUs) to allocate for flexible compute shapes. This applies only to shapes that support customization."
  default = 1
}

variable "FlexShapeMemory" {
  description = "The amount of memory (in GB) to allocate for flexible compute shapes. This applies only to shapes that support customization."
  default = 2
}

# Operating System Variables
variable "instance_os" {
  description = "The operating system for the compute instance, such as 'Oracle Linux' or 'Ubuntu'."
  default = "Oracle Linux"
}

variable "linux_os_version" {
  description = "The version of the operating system for the compute instance. For example, '8' for Oracle Linux 8."
  default = "8"
}

# Security Configuration Variables
variable "service_ports" {
  description = "A list of TCP ports to open for ingress traffic in the security list. Common ports include 80 (HTTP), 443 (HTTPS), and 22 (SSH)."
  default = [80, 443, 22]
}

