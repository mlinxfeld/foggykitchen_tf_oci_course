resource "oci_identity_compartment" "FoggyKitchenCompartment" {
  name = "FoggyKitchenCompartment"
  description = "FoggyKitchenCompartment"
}

resource "oci_identity_compartment" "ExternalCompartment" {
  name = "ExternalCompartment"
  description = "External Compartment"
}
