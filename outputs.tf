output "network_security_group_id" {
  description = "OCI Network Security Group OCID."
  value       = oci_core_network_security_group.this.id
}

output "network_security_group_ids" {
  description = "Single-item list with the OCI NSG OCID, convenient for modules expecting a list."
  value       = [oci_core_network_security_group.this.id]
}

output "nsg_id" {
  description = "Alias for the OCI Network Security Group OCID."
  value       = oci_core_network_security_group.this.id
}

output "nsg_ids" {
  description = "Alias for the OCI NSG OCID as a single-item list."
  value       = [oci_core_network_security_group.this.id]
}

output "network_security_group_name" {
  description = "OCI Network Security Group display name."
  value       = oci_core_network_security_group.this.display_name
}

output "security_rule_ids" {
  description = "Map of logical rule names to OCI security rule IDs."
  value = {
    for name, rule in oci_core_network_security_group_security_rule.this :
    name => try(rule.security_rules[0].id, rule.id)
  }
}
