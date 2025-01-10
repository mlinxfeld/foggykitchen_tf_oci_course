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
  default     = "10.0.0.0/16"
  description = "CIDR block for the Virtual Cloud Network."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.VCN-CIDR))
    error_message = "VCN-CIDR must be a valid CIDR block."
  }  
}

variable "PrivateSubnet-CIDR" {
  default     = "10.0.1.0/24"
  description = "CIDR block for the private subnet hosting the web servers."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.PrivateSubnet-CIDR))
    error_message = "PrivateSubnet-CIDR must be a valid CIDR block."
  }
}

variable "LBSubnet-CIDR" {
  default     = "10.0.2.0/24"
  description = "CIDR block for the public subnet if any resources require direct internet exposure."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.LBSubnet-CIDR))
    error_message = "LBSubnet-CIDR must be a valid CIDR block."
  }
}

variable "BastionSubnet-CIDR" {
  default     = "10.0.3.0/24"
  description = "CIDR block for the bastion host subnet."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.BastionSubnet-CIDR))
    error_message = "BastionSubnet-CIDR must be a valid CIDR block."
  }
}

variable "bastion_allowed_ip" {
  description = "Trusted IP CIDR blocks for SSH access to the bastion host."
  default     = "0.0.0.0/0" # Replace with actual trusted CIDR
}
# Compute Variables

variable "ComputeCount" {
  default = 3
  description = "Number of compute instances to create."
  validation {
    condition     = var.ComputeCount > 0
    error_message = "ComputeCount must be greater than 0."
  }
}

variable "WebserverShape" {
  default = "VM.Standard.E4.Flex"
  description = "Shape for the compute instance."
  validation {
    condition     = contains(["VM.Standard.E3.Flex", "VM.Standard.E4.Flex", "VM.Standard.A1.Flex", "VM.Optimized3.Flex"], var.WebserverShape)
    error_message = "Shape must be one of the supported shapes: VM.Standard.E3.Flex, VM.Standard.E4.Flex, VM.Standard.A1.Flex, or VM.Optimized3.Flex."
  }
}

variable "WebserverFlexShapeOCPUS" {
  description = "The number of OCPUs (Oracle CPUs) to allocate for flexible compute shapes. This applies only to shapes that support customization."
  default = 1
}

variable "WebserverFlexShapeMemory" {
  description = "The amount of memory (in GB) to allocate for flexible compute shapes. This applies only to shapes that support customization."
  default = 2
}

variable "BastionShape" {
  default = "VM.Standard.E4.Flex"
  description = "Shape for the bastion instance."
  validation {
    condition     = contains(["VM.Standard.E3.Flex", "VM.Standard.E4.Flex", "VM.Standard.A1.Flex", "VM.Optimized3.Flex"], var.BastionShape)
    error_message = "Shape must be one of the supported shapes: VM.Standard.E3.Flex, VM.Standard.E4.Flex, VM.Standard.A1.Flex, or VM.Optimized3.Flex."
  }
}

variable "BastionFlexShapeOCPUS" {
  description = "The number of OCPUs (Oracle CPUs) to allocate for flexible bastion shapes. This applies only to shapes that support customization."
  default = 1
}

variable "BastionFlexShapeMemory" {
  description = "The amount of memory (in GB) to allocate for flexible bastion shapes. This applies only to shapes that support customization."
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
variable "webservice_ports" {
  type        = list(string)
  description = "A list of TCP ports to open for ingress traffic in the security list. Common ports include 80 (HTTP), 443 (HTTPS)."
  default = [80, 443]
}

variable "ssh_ports" {
  type        = list(string)
  description = "List of ports to allow ingress traffic to the bastion host and webservers. Default is 22 for SSH."
  default = [22]
}

# Load Balancer Variables

variable "lb_shape" {
  description = "Defines the shape of the load balancer. Use 'flexible' for dynamic scaling or specify fixed shapes like '10Mbps' or '100Mbps'."
  default     = "flexible"
}

variable "flex_lb_min_shape" {
  description = "Minimum bandwidth (in Mbps) for the flexible load balancer."
  default     = 10
}

variable "flex_lb_max_shape" {
  description = "Maximum bandwidth (in Mbps) for the flexible load balancer."
  default     = 100
}