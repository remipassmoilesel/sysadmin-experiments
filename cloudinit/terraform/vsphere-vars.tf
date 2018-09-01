data "vsphere_datacenter" "dc" {
  name = "vsphere_datacenter"
}

data "vsphere_datastore" "datastore" {
  name = "vol_vm_linux"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name = "vsphere_network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host" {
  name = "vsphere_host"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_resource_pool" "pool" {
  name = "Cluster/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name = "templates/ubuntu18naked"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "template_file" "cloud_init" {
  template = "${file("${path.module}/cloud-init-network.yml")}"
  vars {
    ip_address  = "${var.ip_address}"
  }
}
