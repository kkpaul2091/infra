output "cluster_name" {
  description = "GKE Cluster Name"
  value       = module.gke.cluster_name
}

output "cluster_endpoint" {
  description = "GKE API Endpoint"
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "cluster_location" {
  description = "Cluster Region/Zone"
  value       = module.gke.cluster_location
}

output "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  value       = module.gke.cluster_ca_certificate
  sensitive   = true
}

output "cluster_id" {
  description = "Cluster ID"
  value       = module.gke.cluster_id
}
output "artifact_registry_repository" {
  description = "Artifact Registry repository ID"
  value       = module.artifact_registry.repository_id
}

output "artifact_registry_url" {
  description = "Artifact Registry Docker repository URL"
  value       = module.artifact_registry.repository_url
}
/*
output "artifact_registry_repository" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "artifact_registry_url" {
  value = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}"
}
*/
/*
output "mysql_private_ip" {
  value = google_sql_database_instance.mysql.private_ip_address
}

output "mysql_connection_name" {
  value = google_sql_database_instance.mysql.connection_name
}
*/