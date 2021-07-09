# Public Load Balancer
resource "oci_load_balancer" "FoggyKitchenPublicLoadBalancer" {
  shape = var.lb_shape

  dynamic "shape_details" {
    for_each = local.is_flexible_lb_shape ? [1] : []
    content {
      minimum_bandwidth_in_mbps = var.flex_lb_min_shape
      maximum_bandwidth_in_mbps = var.flex_lb_max_shape
    }
  }
  compartment_id = oci_identity_compartment.FoggyKitchenCompartment.id
  subnet_ids = [
    oci_core_subnet.FoggyKitchenLBSubnet.id
  ]
  display_name               = "FoggyKitchenPublicLoadBalancer"
  network_security_group_ids = [oci_core_network_security_group.FoggyKitchenWebSecurityGroup.id]
}

# LoadBalancer Backendset
resource "oci_load_balancer_backendset" "FoggyKitchenPublicLoadBalancerBackendset" {
  name             = "FoggyKitchenPublicLBBackendset"
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}

# LoadBalancer Listener
resource "oci_load_balancer_listener" "FoggyKitchenPublicLoadBalancerListener" {
  load_balancer_id         = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  name                     = "FoggyKitchenPublicLoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}

# LoadBalanacer Backend for WebServer1 Instance
resource "oci_load_balancer_backend" "FoggyKitchenPublicLoadBalancerBackend1" {
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver1.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

# LoadBalanacer Backend for WebServer2 Instance
resource "oci_load_balancer_backend" "FoggyKitchenPublicLoadBalancerBackend2" {
  load_balancer_id = oci_load_balancer.FoggyKitchenPublicLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenPublicLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver2.private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

