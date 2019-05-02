resource "google_container_cluster" "gke-cluster" {
    name                = "gke-cluster"
    network             = "default"
    # subnetwork          = "us-central1"
    location            = "us-central1"
    min_master_version  = "1.11.8-gke.6"
    # initial_node_count  = 1
    remove_default_node_pool = true

    node_pool {
      name = "default-pool"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "snoop-dogg-pool"
  location   = "us-central1"
  cluster    = "${google_container_cluster.gke-cluster.name}"
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}