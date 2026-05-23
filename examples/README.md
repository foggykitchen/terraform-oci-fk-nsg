# OCI Network Security Groups with Terraform/OpenTofu - Training Examples

This directory contains runnable examples for the **terraform-oci-fk-nsg** module.
The examples focus on practical OCI NSG attachment patterns, starting with a single compute instance and progressing to load balancer frontend protection.

These examples are part of the **[FoggyKitchen.com training ecosystem](https://foggykitchen.com/courses-2/)** and are used across OCI and multicloud courses covering networking, workload isolation, traffic distribution, and architecture fundamentals.

---

## Published Examples

| Example | Title | Key Topics |
|:-------:|:------|:-----------|
| 01 | **Compute Instance With NSG** | VNIC-attached NSG, reserved public IP, public subnet, SSH and HTTP policy, `terraform-oci-fk-compute` and `terraform-oci-fk-public-ip` integration |
| 02 | **Load Balancer With NSG** | frontend NSG, public LB, private backends, `terraform-oci-fk-loadbalancer` and `terraform-oci-fk-compute` integration |

---

## How to Use

The example directory contains:
- Terraform/OpenTofu configuration (`.tf`)
- A focused `README.md` explaining the goal of the example
- A minimal, runnable architecture

To run the compute-attached NSG example:

```bash
cd examples/01_compute_instance_with_nsg
tofu init
tofu plan
tofu apply
```

To run the load-balancer-attached NSG example:

```bash
cd examples/02_load_balancer_with_nsg
tofu init
tofu plan
tofu apply
```

---

## Design Principles

- One example = one architectural goal
- No unused or placeholder resources
- Clear separation of concerns between networking, NSGs, compute, and load balancing
- Examples designed to integrate with other modules such as VCN, Compute, and Load Balancer

---

## Related Resources

- [FoggyKitchen OCI NSG Module (terraform-oci-fk-nsg)](../)
- [FoggyKitchen OCI VCN Module (terraform-oci-fk-vcn)](https://github.com/foggykitchen/terraform-oci-fk-vcn)
- [FoggyKitchen OCI Compute Module (terraform-oci-fk-compute)](https://github.com/foggykitchen/terraform-oci-fk-compute)
- [FoggyKitchen OCI Load Balancer Module (terraform-oci-fk-loadbalancer)](https://github.com/foggykitchen/terraform-oci-fk-loadbalancer)
- [FoggyKitchen Azure NSG Module (terraform-az-fk-nsg)](https://github.com/mlinxfeld/terraform-az-fk-nsg)

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../LICENSE) for details.

---

© 2026 FoggyKitchen.com - Cloud. Code. Clarity.
