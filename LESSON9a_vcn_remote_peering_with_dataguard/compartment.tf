resource "oci_identity_compartment" "FoggyKitchenCompartment" {
  provider = oci.homeregion
  name = "FoggyKitchenCompartment"
  description = "FoggyKitchenCompartment"
  compartment_id = var.compartment_ocid
  provisioner "local-exec" {
    command = "sleep 60"
  }
}

/*
resource "oci_identity_compartment" "ExternalCompartment" {
  provider = oci.homeregion
  name = "ExternalCompartment"
  description = "External Compartment"
  compartment_id = var.compartment_ocid
  provisioner "local-exec" {
    command = "sleep 60"
  }
}
*/