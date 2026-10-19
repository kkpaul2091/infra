output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.this.name
}

output "cluster_id" {
  description = "GKE cluster ID"
  value       = google_container_cluster.this.id
}

output "cluster_location" {
  description = "GKE cluster location"
  value       = google_container_cluster.this.location
}

output "cluster_endpoint" {
  description = "GKE cluster endpoint"
  value       = google_container_cluster.this.endpoint
  sensitive   = true
}

output "node_pool_name" {
  description = "GKE node pool name"
  value       = google_container_node_pool.this.name
}

output "cluster_ca_certificate" {
  description = "Base64 encoded public CA certificate for the GKE cluster"
  value       = google_container_cluster.this.master_auth[0].cluster_ca_certificate
  sensitive   = true
}