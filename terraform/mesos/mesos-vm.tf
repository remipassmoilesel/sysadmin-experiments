

# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}

# Create a folder
resource "vsphere_folder" "mesos-cluster-1" {
  path = "mesos-cluster-1"
}

# Create a file
resource "vsphere_file" "ubuntu_disk" {
  datastore        = "local"
  source_file      = "/home/ubuntu/my_disks/custom_ubuntu.vmdk"
  destination_file = "/my_path/disks/custom_ubuntu.vmdk"
}

# Create a disk image
resource "vsphere_virtual_disk" "extraStorage" {
  size       = 2
  vmdk_path  = "myDisk.vmdk"
  datacenter = "Datacenter"
  datastore  = "local"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "master" {
  name   = "terraform-web"
  folder = "${vsphere_folder.mesos-cluster-1.path}"
  vcpu   = 1
  memory = 4096

  network_interface {
    label = "VM Network"
  }

  disk {
    template = "debian8"
  }
}
