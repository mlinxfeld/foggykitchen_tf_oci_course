resource "null_resource" "FoggyKitchenWebserver2HTTPD" {
 depends_on = [oci_core_instance.FoggyKitchenWebserver2,oci_core_instance.FoggyKitchenBastionServer,null_resource.FoggyKitchenWebserver2SharedFilesystem]
 provisioner "remote-exec" {
        connection {
                type     = "ssh"
                user     = "opc"
                host     = data.oci_core_vnic.FoggyKitchenWebserver1_VNIC1.private_ip_address
                private_key = tls_private_key.public_private_key_pair.private_key_pem
                script_path = "/home/opc/myssh.sh"
                agent = false
                timeout = "10m"
                bastion_host = data.oci_core_vnic.FoggyKitchenBastionServer_VNIC1.public_ip_address
                bastion_port = "22"
                bastion_user = "opc"
                bastion_private_key = tls_private_key.public_private_key_pair.private_key_pem
        }
  inline = ["echo '== 1. Installing HTTPD package with yum'",
            "sudo -u root yum -y -q install httpd",
            
            "echo '== 2. Adding Alias and Directory sharedfs to /etc/httpd/conf/httpd.conf'",
            "sudo /bin/su -c \"echo 'Alias /shared/ /sharedfs/' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo '<Directory /sharedfs>' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo 'AllowOverride All' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo 'Require all granted' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo '</Directory>' >> /etc/httpd/conf/httpd.conf\"",

            "echo '== 3. Disabling SELinux'",
            "sudo -u root setenforce 0",

            "echo '== 4. Disabling firewall and starting HTTPD service'",
            "sudo -u root service firewalld stop",
            "sudo -u root service httpd start"]
  }
}
