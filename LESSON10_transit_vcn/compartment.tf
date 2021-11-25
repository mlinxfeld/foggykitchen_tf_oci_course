resource "oci_identity_compartment" "FoggyKitchenCompartment" {
  provider       = oci.homeregion
  name           = "FoggyKitchenCompartment"
  description    = "FoggyKitchenCompartment"
  compartment_id = var.compartment_ocid
}

resource "oci_identity_compartment" "ExternalCompartment" {
  provider       = oci.homeregion
  name           = "ExternalCompartment"
  description    = "External Compartment"
  compartment_id = var.compartment_ocid
}
