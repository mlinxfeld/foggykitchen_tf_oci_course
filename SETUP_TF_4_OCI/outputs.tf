output "FoggyKitchenTenancyName" {
  value = [data.oci_identity_tenancy.FoggyKitchenTenancy.name]
}

output "FoggyKitchenTenancyRegion" {
  value = [data.oci_identity_tenancy.FoggyKitchenTenancy.home_region_key]
}

output "FoggyKitchenTenancyDescription" {
  value = [data.oci_identity_tenancy.FoggyKitchenTenancy.description]
}
