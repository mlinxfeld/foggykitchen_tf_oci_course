# Bastion Instance Public IP
output "FoggyKitchenBastionServer_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address]
}

# WebServer Instances Private IPs
output "FoggyKitchenWebserver_Private_IPs_Formatted" {
  value = {
    for i, ip in data.oci_core_vnic.FoggyKitchenWebserver_VNIC1[*].private_ip_address :
    oci_core_instance.FoggyKitchenWebserver[i].display_name => ip
  }
}

# Generated Private Key for WebServer Instance
output "generated_ssh_private_key" {
  value     = tls_private_key.public_private_key_pair.private_key_pem
  sensitive = true
}

# Load Balancer First Public IP
output "FoggyKitchenLoadBalancer_Public_IP" {
  value = oci_load_balancer.FoggyKitchenLoadBalancer.ip_address_details[0].ip_address
}
