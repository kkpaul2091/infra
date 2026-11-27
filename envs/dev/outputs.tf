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
/*
# Outputs for Artifact Registry module
output "artifact_registry_repository" {
  description = "Artifact Registry repository ID"
  value       = module.artifact_registry.repository_id
}

output "artifact_registry_url" {
  description = "Artifact Registry Docker repository URL"
  value       = module.artifact_registry.repository_url
}
output "artifact_registry_location" {
  description = "Artifact Registry location"
  value       = module.artifact_registry.repository_location
}

output "artifact_registry_name" {
  description = "Artifact Registry name"
  value       = module.artifact_registry.repository_name
}
*/
# Artifact Registry Repository IDs
output "artifact_registry_repositories" {
  description = "Artifact Registry repository IDs"
  value       = module.artifact_registry.repository_ids
}

# Artifact Registry Repository URLs
output "artifact_registry_urls" {
  description = "Artifact Registry repository URLs"
  value       = module.artifact_registry.repository_urls
}

# Artifact Registry Repository Locations
output "artifact_registry_locations" {
  description = "Artifact Registry repository locations"
  value       = module.artifact_registry.repository_locations
}

# Artifact Registry Repository Names
output "artifact_registry_names" {
  description = "Artifact Registry repository names"
  value       = module.artifact_registry.repository_names
}
output "artifact_registry_readers" {
  description = "Service accounts with Artifact Registry reader access"
  value       = module.artifact_registry.readers
}

output "artifact_registry_writers" {
  description = "Service accounts with Artifact Registry writer access"
  value       = module.artifact_registry.writers
}