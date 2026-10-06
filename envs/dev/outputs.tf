output "cluster_name" {
  description = "GKE Cluster Name"
  value       = google_container_cluster.my_school_cluster.name
}

output "cluster_endpoint" {
  description = "GKE API Endpoint"
  value       = google_container_cluster.my_school_cluster.endpoint
}

output "cluster_location" {
  description = "Cluster Region/Zone"
  value       = google_container_cluster.my_school_cluster.location
}

output "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  value       = google_container_cluster.my_school_cluster.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_id" {
  description = "Cluster ID"
  value       = google_container_cluster.my_school_cluster.id
}

output "artifact_registry_repository" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "artifact_registry_url" {
  value = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.docker_repo.repository_id}"
}
/*
output "mysql_private_ip" {
  value = google_sql_database_instance.mysql.private_ip_address
}

output "mysql_connection_name" {
  value = google_sql_database_instance.mysql.connection_name
}
*/