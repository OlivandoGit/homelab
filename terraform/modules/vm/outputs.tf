data "template_file" "vm_file_inventory" {
  template = file("./files/templates/vm_inventory.tpl")
  vars = {
    vm_ip = "${join("", [proxmox_vm_qemu.vm.name, " ansible_host=", proxmox_vm_qemu.vm.default_ipv6_address, " ipv4_address=", proxmox_vm_qemu.vm.default_ipv4_address])}"
  }
}

resource "local_file" "vm_file_inventory"{
  content = data.template_file.vm_file_inventory.rendered
  filename = "${var.ansible_inventory}/${var.hostname}"
}

output "vm_ip" {
  value = "${join(" ", [proxmox_vm_qemu.vm.name, proxmox_vm_qemu.vm.default_ipv6_address, proxmox_vm_qemu.vm.default_ipv4_address])}"
}