
variable vsphere_password{
  description   = "Password for vsphere"
  type          = "string"
}

variable vsphere_user{
  description   = "Username for vsphere"
  type          = "string"
  default       = "root"
}

variable vsphere_server_url{
  description   = "URL for vsphere"
  type          = "string"
  default       = "vccloudlab01.bee-labs.net"
}