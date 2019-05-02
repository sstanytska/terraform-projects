resource "google_container_cluster" "gcpcluster" {
  project    = "astral-root-234422"
  name       = "gcpcluster"
  network    = "default"
  subnetwork = "default"
  zone       = "us-central1-a"

  # additional_zones = "${var.additional_zones}"

  master_auth {
    username = "admin"
    password = "StrongP1~assworafasfweaqg32d"
  }
  initial_node_count = "2"
  node_config {
    # machine_type = ""
    # oauth_scopes = [  #   "https://www.googleapis.com/auth/compute",  #   "https://www.googleapis.com/auth/devstorage.read_only",  #   "https://www.googleapis.com/auth/logging.write",  #   "https://www.googleapis.com/auth/monitoring",  # ]
  }
}