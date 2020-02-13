resource "null_resource" "FoggyKitchenWebserver1HTTPD" {
 depends_on = [oci_core_instance.FoggyKitchenWebserver1,oci_core_instance.FoggyKitchenBastionServer,null_resource.FoggyKitchenWebserver1SharedFilesystem]
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
  inline = ["echo '== 1. Installing HTTPD package with yum'",
            "sudo -u root yum -y -q install httpd",

            "echo '== 2. Creating /sharedfs/index.html'",
            "sudo -u root touch /sharedfs/index.html", 
            "sudo /bin/su -c \"echo 'Welcome to FoggyKitchen.com! These are both WEBSERVERS under LB umbrella with shared index.html ...' > /sharedfs/index.html\"",
            
            "echo '== 3. Adding Alias and Directory sharedfs to /etc/httpd/conf/httpd.conf'",
            "sudo /bin/su -c \"echo 'Alias /shared/ /sharedfs/' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo '<Directory /sharedfs>' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo 'AllowOverride All' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo 'Require all granted' >> /etc/httpd/conf/httpd.conf\"",
            "sudo /bin/su -c \"echo '</Directory>' >> /etc/httpd/conf/httpd.conf\"",

            "echo '== 4. Disabling SELinux'",
            "sudo -u root setenforce 0",

            "echo '== 5. Disabling firewall and starting HTTPD service'",
            "sudo -u root service firewalld stop",
            "sudo -u root service httpd start"]
  }
}
