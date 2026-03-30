variable "gcp_credentials_json" {
  type        = string
  description = "Path to GCP service account JSON key"
}

variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region"
}

variable "user" {
  type        = string
  description = "SSH user on the VM"
}

variable "publickeypath" {
  type        = string
  description = "Path to SSH public key"
}

variable "privatekeypath" {
  type        = string
  description = "Path to SSH private key"
}

variable "email" {
  type        = string
  description = "GCP service account email"
}

variable "v2ray_host" {
  type        = string
  description = "Server IP or hostname for client configs"
}

variable "panel_port" {
  type        = number
  description = "3x-ui panel listen port"
}

variable "panel_base_path" {
  type        = string
  description = "Panel base path segment; empty = default path"
}

variable "enable_caddy_tls" {
  type        = bool
  description = "Expose panel via Caddy with HTTPS"
}

variable "proxy_port" {
  type        = number
  description = "Xray proxy inbound port"
}

variable "firewall_tcp_ports" {
  type        = list(number)
  description = "GCP firewall: allowed TCP ports (proxy_port always added; panel_port added when enable_caddy_tls is false)"
}

variable "firewall_udp_ports" {
  type        = list(number)
  description = "GCP firewall: allowed UDP ports"
}

variable "panel_host" {
  type        = string
  description = "Caddy: subdomain or FQDN; empty uses default host"
}

variable "instance_name" {
  type        = string
  description = "Compute Engine instance name"
}

variable "boot_image" {
  type        = string
  description = "Image family"
}

variable "machine_type" {
  type        = string
  description = "Machine type"
}

variable "zone_suffix" {
  type        = string
  description = "Zone suffix (e.g. b for region-b)"
}

variable "cron_restart_schedule" {
  type        = string
  description = "Cron line for 3x-ui container restart"
}

variable "backup_path" {
  type        = string
  description = "Local directory for panel backups"
}
