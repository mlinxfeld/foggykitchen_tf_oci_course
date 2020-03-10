resource "oci_core_volume" "FoggyKitchenWebserver1BlockVolume100G" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADs.availability_domains[1], "name")
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  display_name = "FoggyKitchenWebserver1 BlockVolume 100G"
  size_in_gbs = "100"
}

resource "oci_core_volume_attachment" "FoggyKitchenWebserver1BlockVolume100G_attach" {
    attachment_type = "iscsi"
    compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
    instance_id = oci_core_instance.FoggyKitchenWebserver1.id
    volume_id = oci_core_volume.FoggyKitchenWebserver1BlockVolume100G.id
}


resource "null_resource" "FoggyKitchenWebserver1_oci_iscsi_attach" {
 depends_on = [oci_core_volume_attachment.FoggyKitchenWebserver1BlockVolume100G_attach]

 provisioner "remote-exec" {
    connection {
                type     = "ssh"
                user     = "opc"
                host     = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key = file(var.private_key_oci)
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
                bastion_host = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port = "22"
                bastion_user = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
     inline = ["sudo /bin/su -c \"rm -Rf /home/opc/iscsiattach.sh\""]
  }

 provisioner "file" {
    connection {
                type     = "ssh"
                user     = "opc"
                host     = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key = file(var.private_key_oci)
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
                bastion_host = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port = "22"
                bastion_user = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
    source     = "iscsiattach.sh"
    destination = "/home/opc/iscsiattach.sh"
  }

  provisioner "remote-exec" {
            connection {
                type     = "ssh"
                user     = "opc"
                host     = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key = file(var.private_key_oci)
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
                bastion_host = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port = "22"
                bastion_user = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
  inline = ["sudo /bin/su -c \"chown root /home/opc/iscsiattach.sh\"",
            "sudo /bin/su -c \"chmod u+x /home/opc/iscsiattach.sh\"",
            "sudo /bin/su -c \"/home/opc/iscsiattach.sh\""]
  }

}


resource "null_resource" "FoggyKitchenWebserver1_oci_u01_fstab" {
 depends_on = [null_resource.FoggyKitchenWebserver1_oci_iscsi_attach]

 provisioner "remote-exec" {
        connection {
                type     = "ssh"
                user     = "opc"
                host     = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key = file(var.private_key_oci)
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
                bastion_host = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port = "22"
                bastion_user = "opc"
                bastion_private_key = file(var.private_key_oci)
        }
  inline = ["sudo -u root parted /dev/sdb --script -- mklabel gpt",
            "sudo -u root parted /dev/sdb --script -- mkpart primary ext4 0% 100%",
            "sudo -u root mkfs.ext4 /dev/sdb1",
            "sudo -u root mkdir /u01",
            "sudo -u root mount /dev/sdb1 /u01",
            "sudo /bin/su -c \"echo '/dev/sdb1              /u01  ext4    defaults,noatime,_netdev    0   0' >> /etc/fstab\""
           ]
  }

}



