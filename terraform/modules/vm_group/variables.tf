variable "ssh_key" {
    sensitive = true
}

variable "vm_template" {}

variable "ansible_inventory" {}

variable "vm_user" {
  type = string
}

variable "vm_gateway" {
  type = string
}

variable "group_num_vms" {
  type = number
}

variable "vm_ips" {
  type = list(string)
}

variable "group_pmnodes" {
  type = list(string)
}

variable "vm_cores" {
  type = number
}

variable "vm_memory" {
  type = number
}

variable "vm_root_disk_size" {
  type = number
}

variable "vm_disk_location" {
  type = string
}

variable "group_name" {
  type = string
}