output "FoggyKitchenDepartamentServer1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer1_VNIC1.private_ip_address]
}

output "FoggyKitchenDepartamentServer1_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer1_VNIC1.public_ip_address]
}

output "FoggyKitchenDepartamentServer2_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer2_VNIC1.private_ip_address]
}

output "FoggyKitchenDepartamentServer2_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenDepartamentServer2_VNIC1.public_ip_address]
}

output "FoggyKitchenHubServer1_PrivateIP" {
  value = [data.oci_core_vnic.FoggyKitchenHubServer1_VNIC1.private_ip_address]
}

output "FoggyKitchenHubServer1_PublicIP" {
  value = [data.oci_core_vnic.FoggyKitchenHubServer1_VNIC1.public_ip_address]
}
