resource "vsphere_virtual_machine" "vm_creation_registry" {

  name          = "docker01.bbuzcloud.com"
  vcpu          = "2"
  memory        = "2048"
  domain        = "docker01.bbuzcloud.com"
  dns_servers   = ["10.0.0.1", "10.0.0.2"]

  network_interface {
    label               = "VM Network"
    ipv4_address        = "${var.registry_ip}"
    ipv4_prefix_length  = "21"
    ipv4_gateway        = "10.0.0.254"
  }

  disk {
    template          = "naked/ubuntu16ltsNaked"
    datastore         = "SSD1toCrucialM2"
  }

  provisioner "remote-exec" {
    inline = [
      "ls ~"
    ]
  }
}