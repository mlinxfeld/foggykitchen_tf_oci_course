resource "oci_identity_compartment" "FoggyKitchenCompartment" {
  name = "FoggyKitchenCompartment"
  description = "FoggyKitchen Compartment"
  compartment = var.compartment_ocid
}

