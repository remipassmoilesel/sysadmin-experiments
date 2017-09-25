locals {
  main_folder = "k8s-remi"
}

resource "vsphere_folder" "vm_folder" {
  path = "${local.main_folder}"
  datacenter = "${var.vm_vsphere_datacenter}"
}

resource "vsphere_virtual_machine" "vm_example" {
  depends_on = [
    "vsphere_folder.vm_folder"]
  count = "${length(var.vm_names)}"
  name = "${element(var.vm_names, count.index)}"
  domain = "${var.domain}"
  datacenter = "${var.vm_vsphere_datacenter}"
  cluster = "${var.vsphere_cluster_name}"
  resource_pool = "${var.vsphere_ressource_pool}"
  vcpu = "${var.vm_cpu}"
  memory = "${var.vm_memory}"
  folder = "${local.main_folder}"
  dns_servers = "${var.network_dns_servers}"
  dns_suffixes = [
    "${var.domain}"]
  time_zone = "Europe/Paris"
  detach_unknown_disks_on_delete = true

  network_interface {
    label = "${var.vm_vsphere_network}"
    ipv4_address = "${lookup(var.vm_ips, element(var.vm_names, count.index))}"
    ipv4_prefix_length = "${var.network_prefix}"
    ipv4_gateway = "${var.network_gateway}"
  }

  disk {
    template = "${var.vm_template}"
    datastore = "${lookup(var.vsphere_datastore, element(var.vm_names, count.index))}"
    type = "thin"
  }
}