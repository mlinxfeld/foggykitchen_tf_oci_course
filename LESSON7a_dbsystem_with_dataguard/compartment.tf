resource "oci_identity_compartment" "FoggyKitchenCompartment" {
  provider = oci.homeregion
  name = "FoggyKitchenCompartment"
  description = "FoggyKitchen Compartment"
  compartment_id = var.compartment_ocid
  
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

