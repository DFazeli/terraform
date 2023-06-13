provider "vsphere" {
  # If you use a domain, set your login like this "Domain\\User"
  user           = var.user_vsphere
  password       = var.password_vsphere
  vsphere_server = var.vsphere_server

  # If you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "datacenter" {
  name = var.name_datacenter
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


data "vsphere_compute_cluster" "cluster" {
  name          = "Cluster-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


data "vsphere_virtual_machine" "ubuntu20-04" {
  name          = "ready"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

locals {
  templates = {
    name         = var.vm_name,
    ipv4_address = var.vm_ipv4_address,
    ipv4_gateway = var.vm_ipv4_gateway,
    dns_server_1 = var.vm_dns_server_list[0],
    dns_server_2 = var.vm_dns_server_list[1],
    public_key   = var.public_key,
    ssh_username = var.ssh_username
  }
}



resource "vsphere_virtual_machine" "vm" {
  name                       = var.vm_name
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.disk2.id
  num_cpus                   = var.vm_num_cpus
  memory                     = var.vm_memory
  guest_id                   = "ubuntu64Guest"
  wait_for_guest_net_timeout = var.vm_wait_for_guest_net_timeout
  wait_for_guest_ip_timeout  = var.vm_wait_for_guest_ip_timeout
  network_interface {
    network_id = data.vsphere_network.lan-vm.id
  }
  disk {
    label = "var.vm_name"
    size  = var.vm_disk_size
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu20-04.id
  }
}

