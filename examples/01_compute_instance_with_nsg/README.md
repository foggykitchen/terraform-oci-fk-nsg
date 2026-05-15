# Example 01: Compute Instance With NSG

In this example, we deploy a **single Oracle Cloud Infrastructure (OCI) compute instance**
with a **VNIC-attached Network Security Group (NSG)** using **Terraform/OpenTofu**.
The environment combines:

- `terraform-oci-fk-vcn`
- `terraform-oci-fk-nsg`
- `terraform-oci-fk-compute`

This is the most direct example of using the NSG module as a **workload-scoped security boundary**.

---

## Architecture Overview

This deployment creates:

- A dedicated **VCN** with one **public subnet**
- One **OCI Network Security Group**
- Ingress NSG rules for **SSH** on port `22` and **HTTP** on port `80`
- One **regular OCI compute instance**
- One **public IP** assigned on the primary VNIC
- A small **cloud-init bootstrap** that starts a demo HTTP service

Traffic flow:

- Clients connect directly to the public IP of the compute instance
- The instance VNIC is a member of the NSG created by this module
- The NSG controls which inbound ports are exposed at the workload edge

---

## Deployment Steps

Initialize and apply the Terraform/OpenTofu configuration:

```bash
tofu init
tofu plan
tofu apply
```

If you prefer Terraform:

```bash
terraform init
terraform plan
terraform apply
```

After a successful deployment, Terraform will output:

- The NSG ID
- The instance ID
- The private IP
- The public IP

These outputs make it easy to verify that the instance is reachable
and that the NSG was attached to the primary VNIC.

---

## Runtime Notes

This example keeps the subnet security list intentionally minimal
and places the workload-facing ingress policy in the NSG.

The compute instance should:

- have a public IP on the primary VNIC
- allow SSH on port `22`
- expose a simple HTTP page on port `80`

---

## Cleanup

To remove all resources created by this example:

```bash
tofu destroy
```

Or with Terraform:

```bash
terraform destroy
```

---

## Summary

This example demonstrates:

- how to create an **OCI NSG**
- how to attach it to a **compute primary VNIC**
- how to define explicit **ingress and egress rules**
- how to combine the NSG module with `terraform-oci-fk-vcn` and `terraform-oci-fk-compute`

---

## Learn More

Visit [FoggyKitchen.com](https://foggykitchen.com/) for OCI, multicloud, and Terraform/OpenTofu learning resources.

---

## License

Licensed under the **Universal Permissive License (UPL), Version 1.0**.
See [LICENSE](../../LICENSE) for more details.
