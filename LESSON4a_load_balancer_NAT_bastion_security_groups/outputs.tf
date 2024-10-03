# Bastion Instance Public IP
output "FoggyKitchenBastionServer_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address]
}

# LoadBalancer Public IP
output "FoggyKitchenPublicLoadBalancer_Public_IP" {
  value = [oci_load_balancer.FoggyKitchenPublicLoadBalancer.ip_address_details[*].ip_address]
}

# WebServer1 Instance Private IP
output "FoggyKitchenWebserver1PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address]
}

# WebServer2 Instance Private IP
output "FoggyKitchenWebserver2PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver2_VNIC1.private_ip_address]
}

# Generated Private Key for WebServer Instance
output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}
