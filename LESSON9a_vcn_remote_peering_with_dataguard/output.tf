output "FoggyKitchenBastionServer_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address]
}

output "FoggyKitchenPublicLoadBalancer_Public_IP" {
  value = [oci_load_balancer.FoggyKitchenPublicLoadBalancer.ip_addresses]
}

output "FoggyKitchenWebserver1PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address]
}

output "FoggyKitchenWebserver2PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver2_VNIC1.private_ip_address]
}

output "FoggyKitchenDBServer_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDBSystem_VNIC1.private_ip_address]
}

output "FoggyKitchenBackendserver1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenBackendserver1_VNIC1.private_ip_address]
}

output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}
