resource "oci_file_storage_mount_target" "FoggyKitchenMountTarget" {
  provider = "oci.requestor"
  availability_domain = var.ADs1[1]
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  subnet_id = oci_core_subnet.FoggyKitchenWebSubnet.id
  ip_address = "10.0.1.25"
  display_name = "FoggyKitchenMountTarget"
}

resource "oci_file_storage_export_set" "FoggyKitchenExportset" {
  provider = "oci.requestor"
  mount_target_id = oci_file_storage_mount_target.FoggyKitchenMountTarget.id
  display_name = "FoggyKitchenExportset"
}

resource "oci_file_storage_file_system" "FoggyKitchenFilesystem" {
  provider = "oci.requestor"
  availability_domain = var.ADs1[1]
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenFilesystem"
}

resource "oci_file_storage_export" "FoggyKitchenExport" {
  provider = "oci.requestor"
  export_set_id = oci_file_storage_mount_target.FoggyKitchenMountTarget.export_set_id
  file_system_id = oci_file_storage_file_system.FoggyKitchenFilesystem.id
  path = "/sharedfs"
}


resource "null_resource" "FoggyKitchenWebserver1SharedFilesystem" {
 depends_on = [oci_core_instance.FoggyKitchenWebserver1,oci_core_instance.FoggyKitchenBastionServer,oci_file_storage_export.FoggyKitchenExport]


 provisioner "remote-exec" {
   connection {
                type                = "ssh"
                user                = "opc"
                host                = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key         = file(var.private_key_oci)
                script_path         = "/home/opc/myssh.sh"
                agent               = false
                timeout             = "10m"
                bastion_host        = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port        = "22"
                bastion_user        = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
  inline = [
            "sudo /bin/su -c \"yum install -y -q nfs-utils\"",
            "sudo /bin/su -c \"mkdir -p /sharedfs\"",
            "sudo /bin/su -c \"echo '10.0.1.25:/sharedfs /sharedfs nfs rsize=8192,wsize=8192,timeo=14,intr 0 0' >> /etc/fstab\"",
            "sudo /bin/su -c \"mount /sharedfs\""
            ]
  }

}

resource "null_resource" "FoggyKitchenWebserver2SharedFilesystem" {
 depends_on = [oci_core_instance.FoggyKitchenWebserver2,oci_core_instance.FoggyKitchenBastionServer,oci_file_storage_export.FoggyKitchenExport]

 provisioner "remote-exec" {
   connection {
                type                = "ssh"
                user                = "opc"
                host                = data.oci_core_vnic.FoggyKitchenWebserver2_VNIC1.private_ip_address
                private_key         = file(var.private_key_oci)
                script_path         = "/home/opc/myssh.sh"
                agent               = false
                timeout             = "10m"
                bastion_host        = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port        = "22"
                bastion_user        = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
  inline = [
            "sudo /bin/su -c \"yum install -y -q nfs-utils\"",
            "sudo /bin/su -c \"mkdir -p /sharedfs\"",
            "sudo /bin/su -c \"echo '10.0.1.25:/sharedfs /sharedfs nfs rsize=8192,wsize=8192,timeo=14,intr 0 0' >> /etc/fstab\"",
            "sudo /bin/su -c \"mount /sharedfs\""
            ]
  }

}
