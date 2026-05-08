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

variable "vm_ip" {
  type = string
}

variable "pmnode" {
  type = string
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

variable "hostname" {
  type = string
}

variable "description" {
  type = string
}