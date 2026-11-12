# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_resource "oci_core_network_security_group" {
    defaults = { "id" = "MOCK_OCID_GROUP", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_network_security_group_security_rule" {
    defaults = { "id" = "MOCK_OCID_RULE", "is_valid" = false, "time_created" = "mock-value" }
  }
}
variables {
  name             = "compatibility"
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
  vcn_id           = "MOCK_OCID_MOCK"
}

run "oci9_plan" {
  command = plan
}
