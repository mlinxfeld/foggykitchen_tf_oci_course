# BastionServer_PublicIP
output "FoggyKitchenBastionServer_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address]
}

# Webserver1_PrivateIP
output "FoggyKitchenWebserver1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address]
}

# Webserver2_PrivateIP
output "FoggyKitchenWebserver2_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver2_VNIC1.private_ip_address]
}

# DBServer_PrivateIP
output "FoggyKitchenDBServer_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDBSystem_VNIC1.private_ip_address]
}

# LoadBalancer_Public_IP
output "FoggyKitchenPublicLoadBalancer_Public_IP" {
  value = [oci_load_balancer.FoggyKitchenPublicLoadBalancer.ip_addresses]
}

# DepartamentServer1_PrivateIP
output "FoggyKitchenDepartamentServer1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer1_VNIC1.private_ip_address]
}

# DepartamentServer1_PublicIP
output "FoggyKitchenDepartamentServer1_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer1_VNIC1.public_ip_address]
}

# DepartamentServer2_PrivateIP
output "FoggyKitchenDepartamentServer2_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer2_VNIC1.private_ip_address]
}

# DepartamentServer2_PublicIP
output "FoggyKitchenDepartamentServer2_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer2_VNIC1.public_ip_address]
}

# HubServer1_PrivateIP
output "FoggyKitchenHubServer1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenHubServer1_VNIC1.private_ip_address]
}

# Generated Private Key for WebServer Instances
output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

