#refrrence: https://vmattroman.com/deploying-linux-vm-on-the-vcenter-with-terraform/

provider "vsphere" {
  user           = "administrator@vs.kuber.ir"
  password       = "password"
  vsphere_server = "192.168.9.202"
  allow_unverified_ssl = true
}
data "vsphere_datacenter" "datacenter" {
  name = "big-data"
}
data "vsphere_network" "vmnetwork" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_datastore" "disk1" {
  name          = "Disk-1"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_datastore" "disk2" {
  name          = "Disk-2-1TB"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "lan-vm" {
  name          = "lan-vmnic2"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_network" "wan-network" {
  name          = "Wan-vmnic0"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
output "datacenter_id" {
  value = data.vsphere_datacenter.datacenter.id
}
output "lan-vm" {
  value = data.vsphere_network.lan-vm.id
}
output "wan-network" {
  value = data.vsphere_network.wan-network.id
}
output "vmnetwork" {
  value = data.vsphere_network.vmnetwork.id
}
output "disk1" {
  value = data.vsphere_datastore.disk1.id
}
output "disk2" {
  value = data.vsphere_datastore.disk2.id
}
data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
data "vsphere_virtual_machine" "ubuntu20-04" {
  name          = "ready"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
resource "vsphere_virtual_machine" "vm" {
  name             = "foo"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.disk2.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = "ubuntu64Guest"
  network_interface {
    network_id = data.vsphere_network.lan-vm.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu20-04.id
    customize {
          linux_options {
              host_name = "foo"
              domain = "kuber.ir"
          }
          network_interface {
              ipv4_address = "192.168.10.164"
              ipv4_netmask = "24"
          }
          ipv4_gateway = "192.168.10.8"
          dns_server_list = ["192.168.10.10","8.8.8.8"]
      }
  }
}
