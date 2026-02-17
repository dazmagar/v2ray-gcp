variable "gcp_credentials_json" {
  type        = string
  description = "Path to GCP service account credentials JSON file"
}

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

variable "privatekeypath" {
  type        = string
  description = "Path to private SSH key file (id_rsa)"
}

variable "email" {
  type        = string
  description = "GCP service account email address"
}

variable "v2ray_host" {
  type        = string
  description = "V2Ray/Xray panel host IP or FQDN (for client links)"
}

variable "panel_port" {
  type        = number
  description = "3x-ui panel listen port (change from default 2053 to reduce scan risk)"
  default     = 2053
}

variable "panel_base_path" {
  type        = string
  description = "3x-ui panel base path, e.g. /xui-abc123/ (must start and end with /). Empty = keep default /panel/"
  default     = ""
}

variable "enable_caddy_tls" {
  type        = bool
  description = "Install Caddy as reverse proxy with Let's Encrypt TLS for the panel"
  default     = true
}

variable "proxy_port" {
  type        = number
  description = "Port for VLESS/Reality proxy (Xray). Panel is on 443 via Caddy; set inbound port in 3x-ui to this value."
  default     = 8443
}

variable "panel_host" {
  type        = string
  description = "Panel host when using Caddy: subdomain prefix (e.g. 'ui' -> ui.<v2ray_host>) or full FQDN if it contains a dot. Empty = panel.<v2ray_host>. Add DNS A record to same IP."
  default     = ""
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

variable "cron_restart_schedule" {
  type        = string
  description = "Cron schedule for 3x-ui container restart (default: daily at 3 AM)"
  default     = "0 3 * * *"
}

variable "backup_path" {
  type        = string
  description = "Local path for 3x-ui panel backup (db and config)"
  default     = "./modules/backup/xui_backup"
}
