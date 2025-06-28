resource "proxmox_vm_qemu" "CORE_vms" {
  count = var.CORE_num_vms

  name = "CORE-0${count.index + 1}"
  desc = "Core network service node"

  clone = var.vm_template
  os_type = "cloud-init"

  ciuser = var.CORE_user
  sshkeys = var.ssh_key

  target_node = var.CORE_pmnodes[count.index % length(var.CORE_pmnodes)]

  #Boot with Proxmox node
  onboot = true

  cpu = "host"
  cores = var.CORE_cores
  memory = var.CORE_memory
  balloon = 0

  #Qemu agent active
  agent = 1
  qemu_os = "l26"

  network {
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }

  ipconfig0 = "ip=${var.CORE_ips[count.index]},gw=${var.CORE_gateway}"

  disks {
    scsi {
      scsi0 {
        disk {
          size = var.CORE_root_disk_size
          storage = var.CORE_disk_location
        }
      }
    }
  }

  cloudinit_cdrom_storage = var.CORE_disk_location
  boot = "order=scsi0;net0"

  lifecycle {
    ignore_changes = [ network, disks, sshkeys, target_node ]
  }
}