module "monitoring" {
  source = "./modules/vm_group"

  ssh_key           = var.ssh_key
  vm_template       = var.vm_template
  ansible_inventory = var.ansible_inventory
  vm_user           = "olivando"
  vm_gateway        = "192.168.1.254"

  group_name    = "MONITOR"
  group_num_vms = 1
  vm_ips        = ["192.168.1.215/24"]
  group_pmnodes = ["PM-01"]

  vm_cores          = 4
  vm_memory         = 4096
  vm_root_disk_size = 32
  vm_disk_location  = "local-lvm"
}

output "monitoring_ips" {
  value = module.monitoring.vm_group_ips
}
