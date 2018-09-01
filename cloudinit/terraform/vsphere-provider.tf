provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "vcenter.domain.fr"
  allow_unverified_ssl = true
}