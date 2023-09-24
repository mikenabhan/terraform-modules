variable "domain_name" {
  type      = string
  sensitive = true
}

variable "proxmox_api_pass" {
  type      = string
  sensitive = true
}

variable "proxmox_api_url" {
  type      = string
  sensitive = true
}

variable "proxmox_api_user" {
  type      = string
  sensitive = true
}

variable "pve_host" {
  type      = string
  sensitive = true
}

variable "pve_ssh_user" {
  type      = string
  sensitive = true
}

variable "pve_ssh_pass" {
  type      = string
  sensitive = true
}

variable "hostname" {
  type    = string
  default = "module-instance"
}

variable "target_node" {
  type      = string
  sensitive = false
}

variable "gh_ssh_import_user" {
  type      = string
  sensitive = false
}

variable "proxmox_clone_target" {
  type      = string
  sensitive = false
  default   = "silver-image"
}

variable "instance_cpu" {
  type      = string
  sensitive = false
  default   = 1
}

variable "instance_memory" {
  type      = string
  sensitive = false
  default   = 1024
}

variable "instance_storage_size" {
  type      = string
  sensitive = false
  default   = "32G"
}

variable "instance_storage" {
  type      = string
  sensitive = false
  default   = "nvme"
}