output "network_security_group_id" {
  value = module.load_balancer_nsg.network_security_group_id
}

output "load_balancer_id" {
  value = module.loadbalancer.load_balancer_id
}

output "load_balancer_public_ips" {
  value = module.loadbalancer.load_balancer_public_ips
}

output "instance_private_ips" {
  value = [for instance in module.compute : instance.instance_private_ip]
}
