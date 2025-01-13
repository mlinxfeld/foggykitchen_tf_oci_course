# Public Load Balancer
resource "oci_load_balancer" "FoggyKitchenLoadBalancer" {
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
  display_name = "FoggyKitchenPublicLoadBalancer"
}

# LoadBalancer Listener
resource "oci_load_balancer_listener" "FoggyKitchenLoadBalancerListener" {
  load_balancer_id         = oci_load_balancer.FoggyKitchenLoadBalancer.id
  name                     = "FoggyKitchenLoadBalancerListener"
  default_backend_set_name = oci_load_balancer_backendset.FoggyKitchenLoadBalancerBackendset.name
  port                     = 80
  protocol                 = "HTTP"
}

# LoadBalancer Backendset
resource "oci_load_balancer_backendset" "FoggyKitchenLoadBalancerBackendset" {
  name             = "FoggyKitchenLBBackendset"
  load_balancer_id = oci_load_balancer.FoggyKitchenLoadBalancer.id
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/shared/"
  }
}

# LoadBalanacer Backend for WebServer1 Instance
resource "oci_load_balancer_backend" "FoggyKitchenLoadBalancerBackend" {
  count            = var.ComputeCount
  load_balancer_id = oci_load_balancer.FoggyKitchenLoadBalancer.id
  backendset_name  = oci_load_balancer_backendset.FoggyKitchenLoadBalancerBackendset.name
  ip_address       = oci_core_instance.FoggyKitchenWebserver[count.index].private_ip
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

