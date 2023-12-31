cpu                    = 2
cores-per-socket       = 1
ram                    = 2096
disksize               = 30 # in GB
vm-guest-id            = "ubuntu64Guest"
vsphere-unverified-ssl = "true"
vsphere-datacenter     = "big-data"
vsphere-cluster        = "Cluster-01"
vm-datastore           = "Disk-2-1TB"
vm-network             = "lan-vmnic2"
vm-domain              = "kuber.ir"
dns_server_list        = ["192.168.10.10", "8.8.8.8"]
name                   = "ubuntu22-04-test"
ipv4_address           = "192.168.10.166"
ipv4_gateway           = "192.168.10.8"
ipv4_netmask           = "24"
vm-template-name       = "ready"
