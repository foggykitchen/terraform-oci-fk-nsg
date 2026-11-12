# Synthetic fixtures only. Every run is plan-only; no tenancy credentials are used.
mock_provider "oci" {
  mock_data "oci_core_images" {
    defaults = { "id" = "MOCK_OCID_IMAGES", "images" = [{ "agent_features" = [{ "is_management_supported" = false, "is_monitoring_supported" = false }], "base_image_id" = "MOCK_OCID_MOCK", "billable_size_in_gbs" = "mock-value", "compartment_id" = "MOCK_OCID_COMPARTMENT", "create_image_allowed" = false, "defined_tags" = {}, "display_name" = "Oracle-Linux-9", "freeform_tags" = {}, "id" = "MOCK_OCID_IMAGE", "image_source_details" = [{ "bucket_name" = "mock-value", "namespace_name" = "mock-value", "object_name" = "mock-value", "operating_system" = "mock-value", "operating_system_version" = "mock-value", "source_image_type" = "mock-value", "source_type" = "mock-value", "source_uri" = "mock-value" }], "instance_id" = "MOCK_OCID_MOCK", "launch_mode" = "mock-value", "launch_options" = [{ "boot_volume_type" = "mock-value", "firmware" = "mock-value", "is_consistent_volume_naming_enabled" = false, "is_pv_encryption_in_transit_enabled" = false, "network_type" = "mock-value", "remote_data_volume_type" = "mock-value" }], "listing_type" = "mock-value", "operating_system" = "Oracle Linux", "operating_system_version" = "9", "size_in_mbs" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }] }
  }
  mock_data "oci_core_private_ips" {
    defaults = { "id" = "MOCK_OCID_IPS", "private_ips" = [{ "availability_domain" = "MOCK:EU-FRANKFURT-1-AD-1", "cidr_prefix_length" = 1, "compartment_id" = "MOCK_OCID_COMPARTMENT", "defined_tags" = {}, "display_name" = "compatibility", "freeform_tags" = {}, "hostname_label" = "mock-value", "id" = "MOCK_OCID_MOCK", "ip_address" = "10.0.0.10", "ip_state" = "mock-value", "ipv4subnet_cidr_at_creation" = "mock-value", "is_primary" = false, "is_reserved" = false, "lifetime" = "mock-value", "route_table_id" = "MOCK_OCID_MOCK", "subnet_id" = "MOCK_OCID_SUBNET", "time_created" = "mock-value", "vlan_id" = "MOCK_OCID_MOCK", "vnic_id" = "MOCK_OCID_MOCK" }] }
  }
  mock_data "oci_core_services" {
    defaults = { "id" = "MOCK_OCID_SERVICES", "services" = [{ "cidr_block" = "all-fra-services-in-oracle-services-network", "description" = "mock-value", "id" = "mock-service", "name" = "All FRA Services In Oracle Services Network" }] }
  }
  mock_data "oci_core_vnic" {
    defaults = { "availability_domain" = "MOCK:EU-FRANKFURT-1-AD-1", "compartment_id" = "MOCK_OCID_COMPARTMENT", "defined_tags" = {}, "display_name" = "compatibility", "freeform_tags" = {}, "hostname_label" = "mock-value", "id" = "MOCK_OCID_VNIC", "ipv6addresses" = ["mock-value"], "is_primary" = false, "mac_address" = "mock-value", "nsg_ids" = ["mock-value"], "private_ip_address" = "10.0.0.10", "public_ip_address" = "10.0.0.10", "route_table_id" = "MOCK_OCID_MOCK", "security_attributes" = {}, "skip_source_dest_check" = false, "state" = "AVAILABLE", "subnet_id" = "MOCK_OCID_SUBNET", "time_created" = "mock-value", "vlan_id" = "MOCK_OCID_MOCK" }
  }
  mock_data "oci_core_vnic_attachments" {
    defaults = { "id" = "MOCK_OCID_ATTACHMENTS", "vnic_attachments" = [{ "availability_domain" = "MOCK:EU-FRANKFURT-1-AD-1", "compartment_id" = "MOCK_OCID_COMPARTMENT", "create_vnic_details" = [{ "assign_ipv6ip" = false, "assign_private_dns_record" = false, "assign_public_ip" = "mock-value", "defined_tags" = {}, "display_name" = "compatibility", "freeform_tags" = {}, "hostname_label" = "mock-value", "ipv6address_ipv6subnet_cidr_pair_details" = [], "nsg_ids" = [], "private_ip" = "10.0.0.10", "private_ip_id" = "MOCK_OCID_MOCK", "route_table_id" = "MOCK_OCID_MOCK", "security_attributes" = {}, "skip_source_dest_check" = false, "subnet_cidr" = "mock-value", "subnet_id" = "MOCK_OCID_SUBNET", "vlan_id" = "MOCK_OCID_MOCK" }], "display_name" = "compatibility", "id" = "MOCK_OCID_MOCK", "instance_id" = "MOCK_OCID_MOCK", "nic_index" = 1, "state" = "AVAILABLE", "subnet_id" = "MOCK_OCID_SUBNET", "time_created" = "mock-value", "vlan_id" = "MOCK_OCID_MOCK", "vlan_tag" = 1, "vnic_id" = "MOCK_OCID_MOCK" }] }
  }
  mock_data "oci_identity_availability_domains" {
    defaults = { "availability_domains" = [{ "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_MOCK", "name" = "MOCK:EU-FRANKFURT-1-AD-1" }, { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_MOCK", "name" = "MOCK:EU-FRANKFURT-1-AD-2" }, { "compartment_id" = "MOCK_OCID_COMPARTMENT", "id" = "MOCK_OCID_MOCK", "name" = "MOCK:EU-FRANKFURT-1-AD-3" }], "id" = "MOCK_OCID_DOMAINS" }
  }
  mock_resource "oci_autoscaling_auto_scaling_configuration" {
    defaults = { "id" = "MOCK_OCID_CONFIGURATION", "max_resource_count" = 1, "min_resource_count" = 1, "time_created" = "mock-value" }
  }
  mock_resource "oci_core_dhcp_options" {
    defaults = { "id" = "MOCK_OCID_OPTIONS", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_instance" {
    defaults = { "boot_volume_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_INSTANCE", "is_cross_numa_node" = false, "launch_mode" = "mock-value", "private_ip" = "10.0.0.10", "public_ip" = "mock-value", "region" = "eu-frankfurt-1", "security_attributes_state" = "mock-value", "system_tags" = {}, "time_created" = "mock-value", "time_maintenance_reboot_due" = "mock-value" }
  }
  mock_resource "oci_core_instance_configuration" {
    defaults = { "deferred_fields" = ["mock-value"], "id" = "MOCK_OCID_CONFIGURATION", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_instance_pool" {
    defaults = { "actual_size" = 1, "current_size" = 1, "id" = "MOCK_OCID_POOL", "pool_type" = "mock-value", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_internet_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_nat_gateway" {
    defaults = { "id" = "MOCK_OCID_GATEWAY", "nat_ip" = "mock-value", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_network_security_group" {
    defaults = { "id" = "MOCK_OCID_GROUP", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_network_security_group_security_rule" {
    defaults = { "id" = "MOCK_OCID_RULE", "is_valid" = false, "time_created" = "mock-value" }
  }
  mock_resource "oci_core_route_table" {
    defaults = { "id" = "MOCK_OCID_TABLE", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_security_list" {
    defaults = { "id" = "MOCK_OCID_LIST", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_service_gateway" {
    defaults = { "block_traffic" = false, "id" = "MOCK_OCID_GATEWAY", "state" = "AVAILABLE", "time_created" = "mock-value" }
  }
  mock_resource "oci_core_subnet" {
    defaults = { "id" = "MOCK_OCID_SUBNET", "ipv6virtual_router_ip" = "mock-value", "state" = "AVAILABLE", "subnet_domain_name" = "mock-value", "time_created" = "mock-value", "virtual_router_ip" = "mock-value", "virtual_router_mac" = "mock-value" }
  }
  mock_resource "oci_core_vcn" {
    defaults = { "byoipv6cidr_blocks" = ["mock-value"], "default_dhcp_options_id" = "MOCK_OCID_MOCK", "default_route_table_id" = "MOCK_OCID_MOCK", "default_security_list_id" = "MOCK_OCID_MOCK", "id" = "MOCK_OCID_VCN", "ipv6cidr_blocks" = ["mock-value"], "state" = "AVAILABLE", "time_created" = "mock-value", "vcn_domain_name" = "mock-value" }
  }
  mock_resource "oci_load_balancer_backend" {
    defaults = { "id" = "MOCK_OCID_BACKEND", "name" = "compatibility", "state" = "AVAILABLE" }
  }
  mock_resource "oci_load_balancer_backend_set" {
    defaults = { "backend" = [{ "backup" = false, "drain" = false, "ip_address" = "10.0.0.10", "max_connections" = 1, "name" = "compatibility", "offline" = false, "port" = 1, "weight" = 1 }], "id" = "MOCK_OCID_SET", "state" = "AVAILABLE" }
  }
  mock_resource "oci_load_balancer_listener" {
    defaults = { "id" = "MOCK_OCID_LISTENER", "state" = "AVAILABLE" }
  }
  mock_resource "oci_load_balancer_load_balancer" {
    defaults = { "id" = "MOCK_OCID_BALANCER", "ip_address_details" = [{ "ip_address" = "10.0.0.10", "is_public" = false, "reserved_ip" = [{ "id" = "MOCK_OCID_MOCK" }] }], "ip_addresses" = ["mock-value"], "state" = "AVAILABLE", "system_tags" = {}, "time_created" = "mock-value" }
  }
}
variables {
  tenancy_ocid     = "MOCK_OCID_TENANCY"
  user_ocid        = "MOCK_OCID_MOCK"
  fingerprint      = "compatibility"
  private_key_path = "/unused-by-mock"
  region           = "eu-frankfurt-1"
  compartment_ocid = "MOCK_OCID_COMPARTMENT"
}

run "oci9_plan" {
  command = plan
}
