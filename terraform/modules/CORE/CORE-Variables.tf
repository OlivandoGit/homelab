variable "ssh_key" {}

variable "vm_template" {}

variable "ansible_inventory" {}

variable "CORE_user" {
  type = string
}

variable "CORE_gateway" {
  type = string
}

# CORE
variable "CORE_num_vms" {
  type = number
}

variable "CORE_ips" {
  type = list(string)
}

variable "CORE_pmnodes" {
  type = list(string)
}

variable "CORE_cores" {
  type = number
}

variable "CORE_memory" {
  type = number
}

variable "CORE_root_disk_size" {
  type = number
}

variable "CORE_disk_location" {
  type = string
}