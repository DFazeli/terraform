variable "user_vsphere" {
  type    = string
  default = "root"
}

variable "password_vsphere" {
  type    = string
  default = "david"
}

variable "vsphere_server" {
  type    = string
  default = "david"
}

variable "name_datacenter" {
  type    = string
  default = "big-data"
}

variable "vm_name" {
  type    = string
  default = "foo"
}
variable "vm_num_cpus" {

  default = 2
}
variable "vm_memory" {
  default = 1024
}
variable "vm_wait_for_guest_net_timeout" {
  default = 60
}

variable "vm_wait_for_guest_ip_timeout" {
  default = 60
}

variable "vm_disk_size" {
  default = 30
}
variable "vm_host_name" {
  type    = string
  default = "foo"
}
variable "vm_domain" {
  type    = string
  default = "kuber.ir"
}

variable "vm_ipv4_address" {
  type = string
}

variable "vm_ipv4_netmask" {
  default = 24
}

variable "vm_ipv4_gateway" {
  type    = string
  default = "192.168.10.8"
}
variable "vm_dns_server_list" {
  type    = list(string)
  default = ["192.168.10.10", "8.8.8.8"]
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "public_key" {
  type    = string
  default = "AAAAB3NzaC1yc2EAAAADAQABAAABgQC8K9wEfofloKh0kT/bm5ZKJyo3vwRmpBdGB4g+Z+iQzNDhEDBYm9POQ4np26Xzaajjr7xxGTenVf9KT8McOKE0xTLryhqIpfDw60o2F+fZPECwjepIhgf/wGHc/82as3P9Ji4x607FKFHUVnUmR2Nd9ziql/4Z7Pa8hS6IMFE8Ljk+OK7CBkbU0NFrzhNbQvIClzxdtdx5gwTgjv2CADK5bVbzDKlPsc54gBWTk9MY8PeYTV24BV2o9BEfJiLQqIsxjI4hlWJN7pBlb06tv/juqmmMhJ22a11KqpCSbNuhoHh8y+yq3+jfA7e3bzw97sy9k56f3R1Vjbp5cHLdbfM0nkcfkhwYr+5F8V/02CAOUVAzOadLUreLXmPTjXK7lBRZv66M4zWvq7jquyWCKcb8zeChccreV5J58d0QByyTUR7XUYopzzxNkBHEXyVC0RB4xd+KD7aN39hzg/J0Y4pjWKr8dWaBQXx5hCuEfUh/dEuTFf9y2qRAGeVV26j4oZ8="
}

