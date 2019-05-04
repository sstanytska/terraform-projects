provider "google" {
  credentials   = "${file("${var.cpath}")}"   #GOOGLE_CREDENTIALS to the path of a file containing the credential JSON
  project       = "${var.project}"
  region        = "${var.region}"
}
resource "google_container_cluster" "gosonik" {
    name                = "${var.cluster_name}"
    network             = "default"
    subnetwork          = "default"
    zone                = "us-central1-a"
    min_master_version  = "1.11.8-gke.6"
    initial_node_count  = "${var.initial_node_count}"
    
  #  project    = "astral-root-234422"
  #  name       = "gcpcluster"
  #  network    = "default"
  #  subnetwork = "default"
  #  zone       = "us-central1-a"
  # additional_zones = "${var.additional_zones}"
  node_config {
     machine_type = "n1-standard-1"
    # oauth_scopes = [  #   "https://www.googleapis.com/auth/compute",  #   "https://www.googleapis.com/auth/devstorage.read_only",  #   "https://www.googleapis.com/auth/logging.write",  #   "https://www.googleapis.com/auth/monitoring",  # ]
  }
}