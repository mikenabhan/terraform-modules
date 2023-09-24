terraform {
  required_version = ">= 0.14"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.11"
    }
    macaddress = {
      source  = "ivoronin/macaddress"
      version = "0.2.2"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_api_user
  pm_password     = var.proxmox_api_pass
  pm_tls_insecure = true
}
