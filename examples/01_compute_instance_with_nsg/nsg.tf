module "compute_nsg" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-nsg.git"

  name             = "fk-compute-instance-nsg"
  compartment_ocid = var.compartment_ocid
  vcn_id           = module.vcn.vcn_id

  security_rules = [
    {
      name        = "allow-ssh-from-internet"
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
      description = "Allow HTTP from the internet."
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

  freeform_tags = {
    module = "terraform-oci-fk-nsg"
    demo   = "compute-instance-with-nsg"
  }
}
