data "google_compute_image" "ubuntu" {
  family  = var.boot_image
  project = "ubuntu-os-cloud"
}

resource "google_compute_firewall" "default" {
  name    = "v2ray-server-firewall"
  network = "default"
  project = var.project

  allow {
    protocol = "tcp"
    ports    = concat(["22", "443", tostring(var.proxy_port), "37883"], var.enable_caddy_tls ? ["80"] : [tostring(var.panel_port)])
  }

  allow {
    protocol = "udp"
    ports    = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["v2ray-server"]
}

# When Caddy TLS is on, block panel port from internet (panel only via HTTPS)
resource "google_compute_firewall" "deny_panel_port" {
  count   = var.enable_caddy_tls ? 1 : 0
  name    = "v2ray-deny-panel-port"
  network = "default"
  project = var.project

  deny {
    protocol = "tcp"
    ports    = [tostring(var.panel_port)]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["v2ray-server"]
  priority     = 900
}

resource "google_compute_address" "static" {
  name       = "v2ray-static-ip"
  project    = var.project
  region     = var.region
  depends_on = [google_compute_firewall.default]
}

resource "google_compute_instance" "vpn_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  project      = var.project
  zone         = "${var.region}-${var.zone_suffix}"
  tags         = ["v2ray-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = "10"
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "${var.user}:${file(var.publickeypath)}"
  }

  depends_on = [google_compute_firewall.default]

  service_account {
    email  = var.email
    scopes = ["compute-ro"]
  }

  lifecycle {
    create_before_destroy = false
  }
}
