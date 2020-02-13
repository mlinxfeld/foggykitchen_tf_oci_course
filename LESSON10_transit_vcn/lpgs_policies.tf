/*
resource "oci_identity_policy" "FoggyKitchenLPGPolicy1" {
  depends_on     = [oci_identity_compartment.FoggyKitchenCompartment,oci_identity_compartment.ExternalCompartment]
  provider       = oci.admin
  name           = "FoggyKitchenLPGPolicy"
  description    = "FoggyKitchenLocalPeeringPolicy1"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  statements     = ["Allow group Administrators to manage local-peering-from in compartment ${oci_identity_compartment.ExternalCompartment.name}"
  ]
}

resource "oci_identity_policy" "FoggyKitchenLPGPolicy2" {
  depends_on     = [oci_identity_compartment.FoggyKitchenCompartment,oci_identity_compartment.ExternalCompartment]
  provider       = oci.admin
  name           = "FoggyKitchenLPGPolicy"
  description    = "FoggyKitchen LocalPeeringPolicy2"
  compartment_id = oci_identity_compartment.ExternalCompartment.id
  statements     = [
                "Allow group Administrators to manage local-peering-to in compartment ${oci_identity_compartment.ExternalCompartment.name}",
                "Allow group Administrators to inspect vcns in compartment ${oci_identity_compartment.ExternalCompartment.name}",
                "Allow group Administrators to inspect local-peering-gateways in compartment ${oci_identity_compartment.ExternalCompartment.name}"
  ]
}*/
