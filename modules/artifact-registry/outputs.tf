output "repository_id" {
  description = "Artifact Registry repository ID"
  value       = google_artifact_registry_repository.docker_repo.repository_id
}

output "repository_name" {
  description = "Artifact Registry repository name"
  value       = google_artifact_registry_repository.docker_repo.name
}

output "repository_location" {
  description = "Artifact Registry location"
  value       = google_artifact_registry_repository.docker_repo.location
}

output "repository_url" {
  description = "Docker repository URL"
  value = format(
    "%s-docker.pkg.dev/%s/%s",
    var.location,
    var.project_id,
    google_artifact_registry_repository.docker_repo.repository_id
  )
}
