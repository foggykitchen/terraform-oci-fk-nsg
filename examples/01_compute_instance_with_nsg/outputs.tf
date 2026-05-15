output "network_security_group_id" {
  value = module.compute_nsg.network_security_group_id
}

output "instance_id" {
  value = module.compute.instance_id
}

output "instance_private_ip" {
  value = module.compute.instance_private_ip
}

output "instance_public_ip" {
  value = module.public_ip.ip_address
}

output "reserved_public_ip_id" {
  value = module.public_ip.id
}

output "vcn_id" {
  value = module.vcn.vcn_id
}
