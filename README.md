# V2Ray 3x-ui – Terraform deployment for GCP

Terraform module for deploying a V2Ray/Xray VPN server with **3x-ui** web panel on Google Cloud Platform.  
Based on the official **3x-ui** project: https://github.com/MHSanaei/3x-ui

## Links

- **3x-ui**: https://github.com/MHSanaei/3x-ui
- **Xray-core**: https://github.com/XTLS/Xray-core

## Features

- Automated deployment of Xray server with 3x-ui web panel (VMess, VLESS, Trojan, Shadowsocks)
- Docker-based 3x-ui (no build, official image)
- Optional backup of 3x-ui panel database
- Optional cron for container restart

## Client applications

- **Android (NekoBox)**: https://github.com/MatsuriDayo/NekoBoxForAndroid/releases
- **Windows (v2rayN)**: https://github.com/2dust/v2rayN/releases
- **iOS (V2Box – V2ray Client)**: https://apps.apple.com/us/app/v2box-v2ray-client/id6446814690

## Prerequisites

- Terraform >= 1.0
- GCP service account with Compute Engine permissions
- SSH key pair for instance access

## Quick start

1. Copy example configuration:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```

2. Edit `terraform.tfvars`: all variables in `variables.tf` are required (see `terraform.tfvars.example`; no defaults in root module).

3. Initialize and apply:
   ```bash
   terraform init
   terraform apply
   ```

4. Get panel URL:
   ```bash
   terraform output panel_url
   ```
   Default login: `admin` / `admin` — change immediately in Panel Settings (and then secure port/path as recommended).

## Configuration

- **v2ray_host** – IP or FQDN of the server (used in client connection links).
- **Firewall:** `firewall_tcp_ports` / `firewall_udp_ports` in `terraform.tfvars`; **`proxy_port` is always merged into TCP**, **`panel_port` is merged when `enable_caddy_tls` is false** (direct panel). Duplicates removed (`distinct`).

## Backup and restore

- **Normal `terraform apply`** (without recreating the instance) does **not** wipe panel configs: data lives on the VM disk in `/home/<user>/x-ui/` and is only lost when the **instance** is recreated (new VM).
- **Backup (download from server):** the backup module runs when **`instance_id` / `instance_ip` change** (e.g. after VM replacement). A routine `terraform apply` with an unchanged VM does **not** re-run the backup scripts.
  - **Manual backup** without recreating the VM:
    ```bash
    terraform apply -replace="module.backup.null_resource.backup_xui"
    ```
  This copies `/home/<user>/x-ui/` into `backup_path/current/` and `backup_path/<year>/xui.backup.<timestamp>/`.
- **Restore (push to server on new deploy):** if `backup_path/current/` exists and is not empty when you run `terraform apply` (e.g. after a full redeploy), the provisioner **automatically** restores it before starting 3x-ui. Flow: (1) take a manual backup if needed (`-replace=...` above); (2) recreate the instance if required; (3) `terraform apply` — restore runs, then 3x-ui.

## Troubleshooting

- Panel URL: `terraform output panel_url`
- Container: `sudo docker ps -a --filter "name=3x-ui"`
- Logs: `sudo docker logs 3x-ui`
