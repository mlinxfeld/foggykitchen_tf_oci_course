resource "oci_load_balancer" "FoggyKitchenLoadBalancer" {
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id 
  subnet_ids     = [
    oci_core_subnet.FoggyKitchenWebSubnet.id
  ]
  display_name   = "FoggyKitchenLoadBalancer"
}

resource "oci_load_balancer_backendset" "FoggyKitchenLoadBalancerBackendset" {
  name             = "FoggyKitchenLBBackendset"
  load_balancer_id = oci_load_balancer.FoggyKitchenLoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/"
  }
}


resource "oci_load_balancer_listener" "FoggyKitchenLoadBalancerListener" {
  load_balancer_id         = oci_load_balancer.FoggyKitchenLoadBalancer.id
  name                     = "FoggyKitchenLoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.FoggyKitchenLoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "FoggyKitchenLoadBalancerBackend" {
  load_balancer_id = oci_load_balancer.FoggyKitchenLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver1.private_ip
  port             = 80 
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "FoggyKitchenLoadBalancerBackend2" {
  load_balancer_id = oci_load_balancer.FoggyKitchenLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


output "FoggyKitchenLoadBalancer_Public_IP" {
  value = [oci_load_balancer.FoggyKitchenLoadBalancer.ip_addresses]
}

