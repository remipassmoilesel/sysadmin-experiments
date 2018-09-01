variable "ip_address" {
  type = "string"
  default = "192.168.0.10"
}

resource "vsphere_virtual_machine" "http_proxy" {
  name = "vm_name"

  resource_pool_id = "${data.vsphere_resource_pool.pool.id}"
  folder = "linux/environment"

  num_cpus = 4
  memory = 2048
  guest_id = "ubuntu64Guest"

  datastore_id = "${data.vsphere_datastore.datastore.id}"

  network_interface {
    network_id = "${data.vsphere_network.network.id}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

  disk {
    label = "disk0"
    size = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  provisioner "file" {
    content = "${data.template_file.cloud_init.rendered}"
    destination = "/etc/cloud/cloud.cfg.d/50-networking.cfg"
  }

}
