
# =====================================
# Docker registry configuration
# =====================================

variable registry_ip{
  type          = "string"
  description   = "IP address of registry"
  default       = "10.0.4.128"
}

# =====================================
# vSphere Provider configuration
# =====================================

provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server_url}"

  # if you have a self-signed cert
  allow_unverified_ssl = true
}






