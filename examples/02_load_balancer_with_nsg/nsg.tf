module "load_balancer_nsg" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-nsg.git"

  name             = "fk-public-load-balancer-nsg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.vcn.vcn_id

  security_rules = [
    {
      name        = "allow-http-from-internet"
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
      description = "Allow HTTP from the internet to the load balancer."
    },
    {
      name             = "allow-all-egress"
      direction        = "EGRESS"
      protocol         = "all"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      description      = "Allow outbound traffic from the load balancer."
    }
  ]

  freeform_tags = {
    module = "terraform-oci-fk-nsg"
    demo   = "load-balancer-with-nsg"
  }
}
