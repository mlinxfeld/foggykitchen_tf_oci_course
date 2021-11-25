# 100 GB Block Volume
resource "oci_core_volume" "FoggyKitchenWebserver1BlockVolume100G" {
  provider            = oci.requestor
  availability_domain = var.availablity_domain_name == "" ? lookup(data.oci_identity_availability_domains.R-ADs.availability_domains[0], "name") : var.availablity_domain_name
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name        = "FoggyKitchenWebserver1 BlockVolume 100G"
  size_in_gbs         = "100"
}

# Attachment of 100 GB Block Volume to Webserver1
resource "oci_core_volume_attachment" "FoggyKitchenWebserver1BlockVolume100G_attach" {
  provider        = oci.requestor
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.FoggyKitchenWebserver1.id
  volume_id       = oci_core_volume.FoggyKitchenWebserver1BlockVolume100G.id
}
