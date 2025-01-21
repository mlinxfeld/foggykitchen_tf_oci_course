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

variable "region1" {
  description = "The first region where OCI resources will be deployed, such as 'us-ashburn-1' or 'eu-frankfurt-1'."
  default = "eu-frankfurt-1"
}

variable "region2" {
  description = "The seecond region where OCI resources will be deployed, such as 'us-ashburn-1' or 'eu-frankfurt-1'."
  default = "eu-amsterdam-1"
}

# Availability Domain Configuration

variable "availability_domain_name" {
  description = "The name of the availability domain in region1 where resources will be deployed. Leave empty to default to the first available domain."
  default = ""
}

variable "availability_domain_name2" {
  description = "The name of the availability domain in region2 where resources will be deployed. Leave empty to default to the first available domain."
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

variable "DBSystemSubnet-CIDR" {
  default = "10.0.4.0/24"
  description = "CIDR block for the DB System subnet."
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.DBSystemSubnet-CIDR))
    error_message = "DBSystemSubnet-CIDR must be a valid CIDR block."
  }
}

variable "VCN-CIDR2" {
  default = "192.168.0.0/16"  
  description = "CIDR block for the secondary VCN"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.VCN-CIDR2))
    error_message = "VCN-CIDR2 must be a valid CIDR block."
  }  
}

variable "BackendSubnet-CIDR" {
  default = "192.168.1.0/24"
  description = "CIDR block for the backend subnet within the secondary VCN"
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.BackendSubnet-CIDR))
    error_message = "BackendSubnet-CIDR must be a valid CIDR block."
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

variable "BackendServerShape" {
  default = "VM.Standard.E4.Flex"
  description = "Shape for the Backend Server instance."
  validation {
    condition     = contains(["VM.Standard.E3.Flex", "VM.Standard.E4.Flex", "VM.Standard.A1.Flex", "VM.Optimized3.Flex"], var.BackendServerShape)
    error_message = "Shape must be one of the supported shapes: VM.Standard.E3.Flex, VM.Standard.E4.Flex, VM.Standard.A1.Flex, or VM.Optimized3.Flex."
  }
}

variable "BackendServerFlexShapeOCPUS" {
  description = "The number of OCPUs (Oracle CPUs) to allocate for flexible BackendServer shapes. This applies only to shapes that support customization."
  default = 1
}

variable "BackendServerFlexShapeMemory" {
  description = "The amount of memory (in GB) to allocate for flexible BackendServer shapes. This applies only to shapes that support customization."
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
  description = "A list of TCP ports to open for ingress traffic in the security list. Common ports include 80 (HTTP), 443 (HTTPS)."
  default = [80, 443]
}

variable "ssh_ports" {
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

# FSS Variables

variable "MountTargetIPAddress" {
  description = "Mount Target IP Address"
  default = "10.0.1.25"
}

# Block Volume Variables

variable "volume_size_in_gbs" {
  description = "The size of the block volume in gigabytes. Adjust this value based on your application's storage requirements."
  default     = 100
  validation {
    condition     = var.volume_size_in_gbs > 0
    error_message = "Volume size must be greater than 0 GB."
  }
}

variable "vpus_per_gb" {
  description = "The performance level of the block volume. Accepted values: 0=Low Cost, 10=Balanced, 20=HigherPerformance, or 30=UltraHighPerformance."
  default     = 10
  validation {
    condition     = contains([0, 10, 20, 30], var.vpus_per_gb)
    error_message = "Volume performance must be one of the following values: 0=Low Cost, 10=Balanced, 20=HigherPerformance, or 30=UltraHighPerformance."
  }
}

# DB System Variables

variable "sqlnet_ports" {
  description = "Ports for SQL*Net access"
  default     = [1521]
}

variable "DBNodeCount" {
  description = "Number DB nodes"
  default     = 1
}

variable "DBNodeShape" {
  description = "Shape of the DB node"
  default     = "VM.Standard.E4.Flex"
}

variable "CPUCoreCount" {
  description = "Number of CPU cores"
  default     = 1
}

variable "DBEdition" {
  description = "Database edition"
  default     = "STANDARD_EDITION"
}

variable "DBAdminPassword" {
  description = "Administrator password for the database"
  default     = "BEstrO0ng_#11"
}

variable "DBName" {
  description = "Database name"
  default     = "FOGGYDB"
}

variable "DBVersion" {
  description = "Version of the database"
  default     = "19.25.0.0"
}

variable "DBDisplayName" {
  description = "Display name for the database"
  default     = "FoggyDB"
}

variable "DBDiskRedundancy" {
  description = "Disk redundancy for the database"
  default     = "HIGH"
}

variable "DBSystemDisplayName" {
  description = "Display name for the database system"
  default     = "FoggyKitchenDBSystem"
}

variable "DBNodeDomainName" {
  description = "Domain name for the DB node"
  default     = "FoggyKitchenN4.FoggyKitchenVCN.oraclevcn.com"
}

variable "DBNodeHostName" {
  description = "Host name for the DB node"
  default     = "foggydbnode"
}

variable "HostUserName" {
  description = "User name for the host"
  default     = "opc"
}

variable "NCharacterSet" {
  description = "National character set for the database"
  default     = "AL16UTF16"
}

variable "CharacterSet" {
  description = "Character set for the database"
  default     = "AL32UTF8"
}

variable "DBWorkload" {
  description = "Database workload type"
  default     = "OLTP"
}

variable "PDBName" {
  description = "Pluggable database name"
  default     = "FKPDB1"
}

variable "DBDataStorageSizeInGB" {
  description = "Data storage size in GB"
  default     = 256
}

variable "DBLicenseModel" {
  description = "License model for the database"
  default     = "LICENSE_INCLUDED"
}
