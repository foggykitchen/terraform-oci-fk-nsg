# terraform-oci-fk-nsg

This repository contains a reusable **Terraform/OpenTofu module** and progressive examples for defining and attaching **Oracle Cloud Infrastructure (OCI) Network Security Groups (NSGs)** to **compute VNICs** and **load balancers** in a clean, explicit, and architecture-aware way.

It is part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and is designed as a dedicated **network security boundary layer** for OCI workloads.

---

## Purpose

The goal of this repository is to provide a **clean, composable, and educational reference implementation** for OCI network security groups:

- Focused on OCI-native NSG primitives
- Suitable for both compute-attached and load-balancer-attached security boundaries
- Designed for hands-on learning, module composition, and multicloud comparisons

This is **not** a landing zone, platform framework, or full security stack.
It is a **learning-first, architecture-aware module**.

---

## What the module does

The module creates:

- One OCI Network Security Group
- Zero or more OCI NSG security rules
- Outputs ready to plug into `terraform-oci-fk-compute` and `terraform-oci-fk-loadbalancer`

The module intentionally does **not** create:

- VCNs or subnets
- Compute instances or instance pools
- Load balancers
- Route tables, gateways, or security lists
- Bastion hosts
- WAF or firewall services

Each of those concerns belongs in its own dedicated module.

---

## Repository Structure

```bash
terraform-oci-fk-nsg/
├── examples/
│   ├── 01_compute_instance_with_nsg/
│   ├── 02_load_balancer_with_nsg/
│   └── README.md
├── main.tf
├── inputs.tf
├── outputs.tf
├── versions.tf
├── LICENSE
└── README.md
```

All examples are runnable and demonstrate **incremental OCI NSG usage patterns**, starting with a single compute instance and progressing to load balancer integration.

---

## Example Usage

### NSG attached to compute with reserved public IP

```hcl
module "compute_nsg" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-nsg.git?ref=v1.0.0"

  name             = "fk-compute-nsg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.vcn.vcn_id

  security_rules = [
    {
      name        = "allow-ssh"
      direction   = "INGRESS"
      protocol    = "6"
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      tcp_options = {
        destination_port_range = {
          min = 22
          max = 22
        }
      }
      description = "Allow SSH from the internet."
    },
    {
      name             = "allow-all-egress"
      direction        = "EGRESS"
      protocol         = "all"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      description      = "Allow outbound traffic."
    }
  ]
}

module "compute" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-compute.git?ref=v0.2.1"

  name             = "fk-web-01"
  tenancy_ocid     = var.tenancy_ocid
  compartment_ocid = var.compartment_ocid
  subnet_id        = module.vcn.subnet_ids["public"]
  nsg_ids          = module.compute_nsg.nsg_ids

  deployment_mode          = "instance"
  shape                    = "VM.Standard.E4.Flex"
  operating_system_version = "9"
  assign_public_ip         = false

  shape_config = {
    ocpus         = 1
    memory_in_gbs = 8
  }
}

module "public_ip" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-public-ip.git?ref=v1.0.0"

  name             = "fk-web-01-public-ip"
  compartment_ocid = var.compartment_ocid
  private_ip_id    = module.compute.primary_private_ip_id
}
```

### NSG attached to load balancer

```hcl
module "load_balancer_nsg" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-nsg.git?ref=v1.0.0"

  name             = "fk-lb-nsg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.vcn.vcn_id

  security_rules = [
    {
      name        = "allow-http-internet"
      direction   = "INGRESS"
      protocol    = "6"
      source      = "0.0.0.0/0"
      source_type = "CIDR_BLOCK"
      tcp_options = {
        destination_port_range = {
          min = 80
          max = 80
        }
      }
    },
    {
      name             = "allow-all-egress"
      direction        = "EGRESS"
      protocol         = "all"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
    }
  ]
}

module "loadbalancer" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-loadbalancer.git?ref=v1.0.0"

  name                       = "fk-public-lb"
  compartment_ocid           = var.compartment_ocid
  subnet_ids                 = [module.vcn.subnet_ids["public_lb"]]
  network_security_group_ids = module.load_balancer_nsg.network_security_group_ids

  health_checker = {
    protocol = "HTTP"
    port     = 80
    url_path = "/"
  }

  listener = {
    name     = "http"
    port     = 80
    protocol = "HTTP"
  }
}
```

---

## Module Inputs

| Variable | Type | Required | Description |
|--------|------|----------|-------------|
| `name` | `string` | ✅ | Base display name used for OCI NSG resources |
| `compartment_ocid` | `string` | ✅ | OCI compartment OCID |
| `vcn_id` | `string` | ✅ | VCN OCID where the NSG will be created |
| `display_name` | `string` | ❌ | Optional display name override |
| `security_rules` | `list(object)` | ❌ | Logical list of OCI NSG security rules |
| `defined_tags` | `map(string)` | ❌ | Defined tags |
| `freeform_tags` | `map(string)` | ❌ | Freeform tags |

### Security rule object schema

```hcl
security_rules = list(object({
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
```

---

## Outputs

| Output | Description |
|------|-------------|
| `network_security_group_id` | OCI NSG OCID |
| `network_security_group_ids` | Single-item list with the OCI NSG OCID |
| `nsg_id` | Alias for OCI NSG OCID |
| `nsg_ids` | Alias for OCI NSG OCID as a single-item list |
| `network_security_group_name` | OCI NSG display name |
| `security_rule_ids` | Map of logical rule names to OCI security rule IDs |

---

## Examples Overview

| Example | Description |
|-------|-------------|
| `01_compute_instance_with_nsg` | Public single OCI compute instance with a VNIC-attached NSG and a reserved public IP controlling SSH and HTTP access |
| `02_load_balancer_with_nsg` | Public OCI Load Balancer with a dedicated NSG on the frontend and private backend instances behind it |

See [`examples/`](examples) for details.

---

## Design Philosophy

- Security boundaries must be **explicit**
- NSGs should be attached where the traffic policy actually belongs
- Compute and load balancer security should remain **separate concerns**
- One module = one responsibility
- Examples should reflect OCI-native composition patterns

This repository intentionally avoids abstractions that hide NSG mechanics behind implicit defaults.

---

## Related Modules And Training

- [terraform-oci-fk-vcn](https://github.com/foggykitchen/terraform-oci-fk-vcn)
- [terraform-oci-fk-compute](https://github.com/foggykitchen/terraform-oci-fk-compute)
- [terraform-oci-fk-loadbalancer](https://github.com/mlinxfeld/terraform-oci-fk-loadbalancer)
- [terraform-az-fk-nsg](https://github.com/mlinxfeld/terraform-az-fk-nsg)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](LICENSE) for details.

---

© 2026 FoggyKitchen.com - Cloud. Code. Clarity.
