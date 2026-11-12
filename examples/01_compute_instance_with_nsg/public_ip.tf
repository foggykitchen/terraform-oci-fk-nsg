module "public_ip" {
  source = "git::https://github.com/foggykitchen/terraform-oci-fk-public-ip.git?ref=v2.0.0" # TODO: tag not yet released

  name             = "fk-compute-instance-public-ip"
  compartment_ocid = var.compartment_ocid
  private_ip_id    = module.compute.primary_private_ip_id

  freeform_tags = {
    module = "terraform-oci-fk-public-ip"
    demo   = "compute-instance-with-nsg"
  }
}
