variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region for resources deployment"
}

variable "user" {
  type        = string
  description = "SSH username for VM instance access"
}

variable "publickeypath" {
  type        = string
  description = "Path to public SSH key file (id_rsa.pub)"
}

variable "email" {
  type        = string
  description = "GCP service account email address"
}

variable "instance_name" {
  type        = string
  description = "Name of the compute instance"
  default     = "v2ray-server"
}

variable "boot_image" {
  type        = string
  description = "Boot image family for the instance"
  default     = "ubuntu-2404-lts-amd64"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the compute instance"
  default     = "e2-micro"
}

variable "zone_suffix" {
  type        = string
  description = "Zone suffix (a, b, c, etc.)"
  default     = "b"
}

variable "panel_port" {
  type        = number
  description = "3x-ui panel port (opened in firewall)"
  default     = 2053
}

variable "enable_caddy_tls" {
  type        = bool
  description = "Open port 80 and panel_https_port when Caddy is used"
  default     = true
}

variable "proxy_port" {
  type        = number
  description = "Port for Xray proxy (VLESS/Reality inbound in 3x-ui)"
  default     = 8443
}
