resource "google_container_cluster" "my_school_cluster" {
  name     = "my-school-cluster"
  location = "australia-southeast2-a"

  deletion_protection = false

  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = "REGULAR" # Release channel options: RAPID, REGULAR, STABLE # REGULAR=GKE will automatically choose and upgrade to a version available in the REGULAR channel.
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "my-school-node-pool"
  location   = google_container_cluster.my_school_cluster.location
  cluster    = google_container_cluster.my_school_cluster.name

  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  node_config {
    machine_type = "e2-standard-2"
    disk_size_gb = 40
    disk_type = "pd-balanced"

  labels = {
      environment = "dev"
      project     = "my-school"
      owner       = "kanu"
      workload    = "general"
      managed_by = "terraform"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}
