resource "google_compute_instance" "vm" {
  project    = "$(google_project.demo.project_id)"
  name       = "dev-instance"
  machine_type = "n1-standatr-1"
  zone         = "us-central1-f"

  disk {
      image = "debian-cloud/debian-8"
  }

  network_interface {
      network = "default"

      access_config {
          // Ephemeral IP
      }
  }
 }
