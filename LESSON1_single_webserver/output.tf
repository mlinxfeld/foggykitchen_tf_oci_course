output "FoggyKitchenWebserver1PublicIP" {
   value = [data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.public_ip_address]
}