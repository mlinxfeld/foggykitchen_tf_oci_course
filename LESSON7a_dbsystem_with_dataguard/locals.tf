# Dictionary Locals
locals {
  compute_flexible_shapes = [
    "VM.Standard.E3.Flex",
    "VM.Standard.E4.Flex",
    "VM.Standard.A1.Flex",
    "VM.Optimized3.Flex"
  ]
  is_flexible_webserver_shape = contains(local.compute_flexible_shapes, var.WebserverShape)
  is_flexible_bastion_shape = contains(local.compute_flexible_shapes, var.BastionShape)
  is_flexible_lb_shape = var.lb_shape == "flexible" ? true : false
}
