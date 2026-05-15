locals {
  nsg_name = coalesce(var.display_name, var.name)

  security_rules_by_name = {
    for rule in var.security_rules : rule.name => rule
  }
}

resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_ocid
  vcn_id         = var.vcn_id
  display_name   = local.nsg_name
  defined_tags   = var.defined_tags
  freeform_tags  = var.freeform_tags
}

resource "oci_core_network_security_group_security_rule" "this" {
  for_each = local.security_rules_by_name

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = each.value.direction
  protocol                  = each.value.protocol
  description               = try(each.value.description, null)
  source                    = try(each.value.source, null)
  source_type               = try(each.value.source_type, null)
  destination               = try(each.value.destination, null)
  destination_type          = try(each.value.destination_type, null)
  stateless                 = try(each.value.stateless, false)

  dynamic "icmp_options" {
    for_each = try(each.value.icmp_options, null) == null ? [] : [each.value.icmp_options]

    content {
      type = icmp_options.value.type
      code = try(icmp_options.value.code, null)
    }
  }

  dynamic "tcp_options" {
    for_each = try(each.value.tcp_options, null) == null ? [] : [each.value.tcp_options]

    content {
      dynamic "destination_port_range" {
        for_each = try(tcp_options.value.destination_port_range, null) == null ? [] : [tcp_options.value.destination_port_range]

        content {
          min = destination_port_range.value.min
          max = destination_port_range.value.max
        }
      }

      dynamic "source_port_range" {
        for_each = try(tcp_options.value.source_port_range, null) == null ? [] : [tcp_options.value.source_port_range]

        content {
          min = source_port_range.value.min
          max = source_port_range.value.max
        }
      }
    }
  }

  dynamic "udp_options" {
    for_each = try(each.value.udp_options, null) == null ? [] : [each.value.udp_options]

    content {
      dynamic "destination_port_range" {
        for_each = try(udp_options.value.destination_port_range, null) == null ? [] : [udp_options.value.destination_port_range]

        content {
          min = destination_port_range.value.min
          max = destination_port_range.value.max
        }
      }

      dynamic "source_port_range" {
        for_each = try(udp_options.value.source_port_range, null) == null ? [] : [udp_options.value.source_port_range]

        content {
          min = source_port_range.value.min
          max = source_port_range.value.max
        }
      }
    }
  }
}
