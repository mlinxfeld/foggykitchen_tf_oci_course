# Block Volume
resource "oci_core_volume" "FoggyKitchenWebserverBlockVolume" {
  count               = var.ComputeCount
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[count.index % length(data.oci_identity_availability_domains.ADs.availability_domains)], "name") 
  compartment_id      = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name        = "FoggyKitchenWebserver${count.index + 1} BlockVolume"
  size_in_gbs         = var.volume_size_in_gbs
  vpus_per_gb         = var.vpus_per_gb
}

# Attachment of Block Volume to Webserver
resource "oci_core_volume_attachment" "FoggyKitchenWebserverBlockVolume_attach" {
  count           = var.ComputeCount
  attachment_type = "iscsi"
  instance_id     = oci_core_instance.FoggyKitchenWebserver[count.index].id
  volume_id       = oci_core_volume.FoggyKitchenWebserverBlockVolume[count.index].id
}

