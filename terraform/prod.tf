module "prod" {
  source = "./modules/vm_group"

  ssh_key = var.ssh_key
  vm_template = var.vm_template
  ansible_inventory = var.ansible_inventory
  vm_user = "olivando"
  vm_gateway = "192.168.1.254"

  group_name = "PROD"
  group_num_vms = 1
  vm_ips = ["192.168.1.210/24"]
  group_pmnodes = [ "PM-01" ]

  vm_cores = 8
  vm_memory = 16384
  vm_root_disk_size = 32
  vm_disk_location = "local-lvm"
}

output "prod_ips" {
  value = module.prod.vm_group_ips
}