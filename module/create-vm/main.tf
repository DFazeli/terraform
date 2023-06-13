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


resource "vsphere_virtual_machine" "vm" {
  count                      = var.vm_count
  name                       = "${var.vm_name}-${count.index}"
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
    label = var.vm_name
    size  = var.vm_disk_size
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.ubuntu20-04.id
  }
}

