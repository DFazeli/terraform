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

