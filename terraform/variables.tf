variable "ssh_key" {
  type = string 
  sensitive = true
}

variable "vm_template" {
  type = string
}

variable "ansible_inventory" {
  type = string
}
