# Software installation within WebServer Instance

resource "null_resource" "FoggyKitchenWebserverHTTPD" {
  count = var.ComputeCount
  triggers = {
    instance_id = oci_core_instance.FoggyKitchenWebserver[count.index].id
  }  
  depends_on = [oci_core_instance.FoggyKitchenWebserver]
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "opc"
      host        = data.oci_core_vnic.FoggyKitchenWebserver_VNIC1[count.index].public_ip_address
      private_key = tls_private_key.public_private_key_pair.private_key_pem
      script_path = "/home/opc/myssh.sh"
      agent       = false
      timeout     = "10m"
    }
    inline = ["echo '== 1. Installing HTTPD package with dnf'",
      "sudo -u root dnf -y -q install httpd",

      "echo '== 2. Creating /var/www/html/index.html'",
      "sudo -u root touch /var/www/html/index.html",
      "sudo /bin/su -c \"echo 'Welcome to FoggyKitchen.com! This is WEBSERVER${count.index + 1}...' > /var/www/html/index.html\"",

      "echo '== 3. Disabling firewall and starting HTTPD service'",
      "sudo -u root service firewalld stop",
      "sudo -u root service httpd start"]
  }
}
