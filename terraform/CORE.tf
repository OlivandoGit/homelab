module "CORE" {
  source = "./modules/CORE"

  # Proxmox 
  proxmox_api_url = var.proxmox_api_url
  proxmox_api_token_id = var.proxmox_api_token_id
  proxmox_api_token_secret = var.proxmox_api_token_secret

  # General
  ssh_key = var.ssh_key
  vm_template = var.vm_template
  ansible_inventory = var.ansible_inventory
  CORE_user = "olivando"
  CORE_gateway = "192.168.1.254"

  CORE_num_vms = 2
  CORE_ips = ["192.168.1.253/24", "192.168.1.252/24"]
  CORE_pmnodes = [ "PM-01" ]

  CORE_cores = 4
  CORE_memory = 4096
  CORE_root_disk_size = 32
  CORE_disk_location = "local-lvm"
}

output "CORE_ips" {
  value = module.CORE.CORE-IPS
}