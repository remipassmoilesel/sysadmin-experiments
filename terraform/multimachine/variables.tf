# =============================
# VSphere variables
# =============================

variable "vsphere_user" {
  description = "Username for vsphere"
  default = "root"
}
variable "vsphere_password" {
  description = "Password for vsphere"
}

provider "vsphere" {
  user = "${var.vsphere_user}"
  password = "${var.vsphere_password}"
  vsphere_server = "vccloudlab01.bee-labs.net"
  allow_unverified_ssl = "true"
}

variable "vm_vsphere_datacenter" {
  default = "cloudlab"
}

variable "vsphere_cluster_name" {
  default = "cluster2"
}

variable "vsphere_ressource_pool" {
  default = "10.0.7.15/Resources/k8s-predev"
}

# =============================
# VM variables
# =============================

variable "domain" {
  description = "Internal domain name"
  default = "predev.bee-labs.net"
}

variable "vm_template" {
  default = "naked/ubuntu16naked"
}

variable "vm_names" {
  type = "list"
  default = [
    "vm01",
    "vm02"]
}

variable "vm_ips" {
  type = "map"
  default = {
    "vm01" = "10.0.4.251"
    "vm02" = "10.0.4.252"
  }
}

variable "vsphere_datastore" {
  type = "map"
  default = {
    "vm01" = "SSD1toCrucialM2"
    "vm02" = "SSD1toCrucialM2"
  }
}

variable "vm_cpu" {
  default = "1"
}

variable "vm_memory" {
  description = "Memory in Mo of vm"
  default = "1024"
}

variable "network_dns_servers" {
  description = "List of dns servers ips"
  type = "list"
  default = [
    "10.0.0.1",
    "10.0.0.2"]
}

variable "vm_vsphere_network" {
  default = "Bbuzg"
}

variable "network_gateway" {
  default = "10.0.0.254"
}

variable "network_prefix" {
  default = "21"
}
