data "template_file" "vm_group_file_inventory" {
  template = file("./files/templates/vm_group_inventory.tpl")
  vars = {
    group_name = var.group_name
    vm_ips = "${join("\n", [for instance in proxmox_vm_qemu.vm_group : join("", [instance.name, " ansible_host=", instance.default_ipv4_address])])}"
  }
}

resource "local_file" "vm_group_file_inventory"{
  content = data.template_file.vm_group_file_inventory.rendered
  filename = "${var.ansible_inventory}/${var.group_name}"
}

output "vm_group_ips" {
  value = "${proxmox_vm_qemu.vm_group.*.default_ipv4_address}"
}