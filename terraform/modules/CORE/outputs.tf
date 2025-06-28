data "template_file" "CORE_file_inventory" {
  template = file("./files/templates/CORE_inventory.tpl")
  vars = {
    CORE_ips = "${join("\n", [for instance in proxmox_vm_qemu.CORE_vms : join("", [instance.name, " ansible_host=", instance.default_ipv4_address])])}"
  }
}

resource "local_file" "CORE_file_inventory"{
  content = data.template_file.CORE_file_inventory.rendered
  filename = "${var.ansible_inventory}/CORE"
}

output "CORE-IPS" {
  value = "${proxmox_vm_qemu.CORE_vms.*.default_ipv4_address}"
}