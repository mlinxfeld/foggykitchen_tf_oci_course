# WebServer Instances Public IPs
output "FoggyKitchenWebserversPublicIPs" {
  value = [data.oci_core_vnic.FoggyKitchenWebserver_VNIC1[*].public_ip_address]
}

# Generated Private Key for WebServer Instance
output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}
