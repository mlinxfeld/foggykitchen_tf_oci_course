resource "oci_load_balancer" "FoggyKitchenPublicLoadBalancer" {
  provider       = oci.requestor
  shape          = "100Mbps"
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id 
  subnet_ids     = [
    oci_core_subnet.FoggyKitchenLBSubnet.id
  ]
  display_name   = "FoggyKitchenPublicLoadBalancer"
}

resource "oci_load_balancer_backendset" "FoggyKitchenPublicLoadBalancerBackendset" {
  provider         = oci.requestor
  name             = "FoggyKitchenPublicLBBackendset"
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port     = "80"
    protocol = "HTTP"
    response_body_regex = ".*"
    url_path = "/shared/"
    interval_ms = "3000"
  }
}


resource "oci_load_balancer_listener" "FoggyKitchenPublicLoadBalancerListener" {
  provider                 = oci.requestor
  load_balancer_id         = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  name                     = "FoggyKitchenPublicLoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "FoggyKitchenPublicLoadBalancerBackend1" {
  provider         = oci.requestor
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver1.private_ip
  port             = 80 
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "FoggyKitchenPublicLoadBalancerBackend2" {
  provider         = oci.requestor
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


output "FoggyKitchenPublicLoadBalancer_Public_IP" {
  value = [oci_load_balancer.FoggyKitchenPublicLoadBalancer.ip_addresses]
}

