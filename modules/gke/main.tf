resource "google_container_cluster" "this" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id
  network    = var.network
  subnetwork = var.subnetwork

  deletion_protection = var.deletion_protection

  # We manage the node pool separately.
  remove_default_node_pool = true
  initial_node_count       = 1

  release_channel {
    channel = var.release_channel
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }
}

resource "google_container_node_pool" "this" {
  name     = var.node_pool_name
  location = google_container_cluster.this.location
  cluster  = google_container_cluster.this.name

  initial_node_count = var.initial_node_count

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size_gb
    disk_type    = var.disk_type

    labels = var.node_labels

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }
}