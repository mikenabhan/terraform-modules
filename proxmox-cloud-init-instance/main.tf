variable "vm_count" {
  type    = number
  default = 1
}


/* Null resource that generates a cloud-config file per vm */

data "template_file" "user_data" {
  template = file("${path.module}/files/user_data.cfg")
  vars = {
    pubkey   = file("~/.ssh/id_rsa.pub")
    hostname = "${var.hostname}"
    fqdn     = "${var.hostname}.${var.domain_name}"
  }
}
resource "local_file" "cloud_init_user_data_file" {
  content  = data.template_file.user_data.rendered
  filename = "${path.module}/files/user_data-rendered.yml"
}

resource "null_resource" "cloud_init_config_files" {
  count = var.vm_count
  connection {
    type     = "ssh"
    user     = var.pve_ssh_user
    password = var.pve_ssh_pass
    host     = var.pve_host
  }

  provisioner "file" {
    source      = local_file.cloud_init_user_data_file.filename
    destination = "/var/lib/vz/snippets/user_data_instance_${var.hostname}.yml"
  }
}

/* Configure cloud-init User-Data with custom config file */
resource "proxmox_vm_qemu" "instance" {
  depends_on = [
    null_resource.cloud_init_config_files,
  ]

  name        = var.hostname
  desc        = "created by terraform"
  target_node = var.target_node

  clone = var.proxmox_clone_target
  agent = "1"

  cores  = var.instance_cpu
  memory = var.instance_memory

  os_type = "cloud-init"
  network {
    bridge   = "vmbr0"
    firewall = "false"
    model    = "virtio"
  }


  disk {
    type    = "scsi"
    storage = var.instance_storage
    size    = var.instance_storage_size
  }

  ipconfig0 = "ip=dhcp"
  cicustom                = "user=local:snippets/user_data_instance_${var.hostname}.yml"
  cloudinit_cdrom_storage = var.instance_storage

}