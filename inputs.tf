variable "name" {
  description = "Base display name used for OCI Network Security Group resources."
  type        = string

  validation {
    condition     = length(trimspace(var.name)) > 0
    error_message = "name must not be empty."
  }
}

variable "compartment_ocid" {
  description = "Compartment OCID where the NSG will be created."
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID where the NSG will be created."
  type        = string
}

variable "display_name" {
  description = "Optional display name override for the NSG."
  type        = string
  default     = null
}

variable "defined_tags" {
  description = "Defined tags applied to the NSG."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags applied to the NSG."
  type        = map(string)
  default     = {}
}

variable "security_rules" {
  description = <<DESC
List of OCI NSG security rules.

Notes:
- Use `direction = "INGRESS"` with `source` and `source_type`.
- Use `direction = "EGRESS"` with `destination` and `destination_type`.
- Use protocol numbers such as `6` for TCP, `17` for UDP, `1` for ICMP, `58` for ICMPv6, or `all`.
- OCI supports NSG-to-NSG rules with `source_type` or `destination_type` set to `NETWORK_SECURITY_GROUP`.
DESC

  type = list(object({
    name             = string
    direction        = string
    protocol         = string
    description      = optional(string)
    stateless        = optional(bool, false)
    source           = optional(string)
    source_type      = optional(string)
    destination      = optional(string)
    destination_type = optional(string)
    icmp_options = optional(object({
      type = number
      code = optional(number)
    }))
    tcp_options = optional(object({
      destination_port_range = optional(object({
        min = number
        max = number
      }))
      source_port_range = optional(object({
        min = number
        max = number
      }))
    }))
    udp_options = optional(object({
      destination_port_range = optional(object({
        min = number
        max = number
      }))
      source_port_range = optional(object({
        min = number
        max = number
      }))
    }))
  }))

  default = []

  validation {
    condition     = length(var.security_rules) == length(distinct([for rule in var.security_rules : rule.name]))
    error_message = "security_rules names must be unique."
  }

  validation {
    condition     = alltrue([for rule in var.security_rules : contains(["INGRESS", "EGRESS"], rule.direction)])
    error_message = "security_rules.direction must be either INGRESS or EGRESS."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      rule.direction == "INGRESS" ? try(rule.source, null) != null : try(rule.destination, null) != null
    ])
    error_message = "INGRESS rules require source, and EGRESS rules require destination."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      rule.direction == "INGRESS" ? try(rule.source_type, null) != null : try(rule.destination_type, null) != null
    ])
    error_message = "INGRESS rules require source_type, and EGRESS rules require destination_type."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      rule.direction == "INGRESS" ? contains(["CIDR_BLOCK", "SERVICE_CIDR_BLOCK", "NETWORK_SECURITY_GROUP"], rule.source_type) : true
    ])
    error_message = "INGRESS rules require source_type to be CIDR_BLOCK, SERVICE_CIDR_BLOCK, or NETWORK_SECURITY_GROUP."
  }

  validation {
    condition = alltrue([
      for rule in var.security_rules :
      rule.direction == "EGRESS" ? contains(["CIDR_BLOCK", "SERVICE_CIDR_BLOCK", "NETWORK_SECURITY_GROUP"], rule.destination_type) : true
    ])
    error_message = "EGRESS rules require destination_type to be CIDR_BLOCK, SERVICE_CIDR_BLOCK, or NETWORK_SECURITY_GROUP."
  }
}
