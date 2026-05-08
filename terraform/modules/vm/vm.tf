resource "proxmox_vm_qemu" "vm" {

  name = var.hostname
  description = var.description

  clone = var.vm_template
  os_type = "cloud-init"

  ciuser = var.vm_user
  sshkeys = var.ssh_key

  target_node = var.pmnode

  #Boot with Proxmox node
  start_at_node_boot = true
  
  cpu {
    type = "host"
    cores = var.vm_cores
  }
  
  memory = var.vm_memory
  balloon = 0

  #Qemu agent active
  agent = 1
  qemu_os = "l26"

  network {
    id = 0
    model = "virtio"
    bridge = "vmbr0"
    firewall = false
  }

  ipconfig0 = "ip=${var.vm_ip},gw=${var.vm_gateway},ip6=${var.vm_ipv6}"

  disks {
    scsi {
      scsi0 {
        disk {
          size = var.vm_root_disk_size
          storage = var.vm_disk_location
        }
      }
    }

    ide {
      ide3 {
        cloudinit {
          storage = var.vm_disk_location
        }  
      }
    }
  }

#  cloudinit_cdrom_storage = var.vm_disk_location
  boot = "order=scsi0;net0"

  lifecycle {
    ignore_changes = [ network, disks, sshkeys, target_node ]
  }

  skip_ipv6 = false
}
