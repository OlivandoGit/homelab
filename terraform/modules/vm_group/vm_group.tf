resource "proxmox_vm_qemu" "vm_group" {
  count = var.group_num_vms

  name = "${format("${var.group_name}-%0${max(floor(var.group_num_vms / 10), 2)}d", count.index + 1)}"
  desc = "${var.group_name} vm ${count.index}"

  clone = var.vm_template
  os_type = "cloud-init"

  ciuser = var.vm_user
  sshkeys = var.ssh_key

  target_node = var.group_pmnodes[count.index % length(var.group_pmnodes)]

  #Boot with Proxmox node
  onboot = true

  cpu = "host"
  cores = var.vm_cores
  memory = var.vm_memory
  balloon = 0

  #Qemu agent active
  agent = 1
  qemu_os = "l26"

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }

  ipconfig0 = "ip=${var.vm_ips[count.index]},gw=${var.vm_gateway}"

  disks {
    scsi {
      scsi0 {
        disk {
          size = var.vm_root_disk_size
          storage = var.vm_disk_location
        }
      }
    }
  }

  cloudinit_cdrom_storage = var.vm_disk_location
  boot = "order=scsi0;net0"

  lifecycle {
    ignore_changes = [ network, disks, sshkeys, target_node ]
  }
}