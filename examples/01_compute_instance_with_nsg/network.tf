module "vcn" {
  source = "git::https://github.com/mlinxfeld/terraform-oci-fk-vcn.git"

  compartment_ocid = var.compartment_ocid
  name             = "fk-nsg-compute-vcn"
  vcn_cidr_blocks  = ["10.90.0.0/16"]

  create_internet_gateway = true

  route_tables = {
    public = {
      route_rules = [
        {
          destination        = "0.0.0.0/0"
          destination_type   = "CIDR_BLOCK"
          network_entity_key = "internet_gateway"
        }
      ]
    }
  }

  security_lists = {
    public_baseline = {
      egress_rules = [
        {
          protocol    = "all"
          destination = "0.0.0.0/0"
        }
      ]
    }
  }

  subnets = {
    public = {
      display_name               = "fk-nsg-compute-public-subnet"
      cidr_block                 = "10.90.10.0/24"
      route_table_key            = "public"
      security_list_keys         = ["public_baseline"]
      prohibit_public_ip_on_vnic = false
    }
  }
}
