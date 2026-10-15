resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = var.format
}

# GKE Pull Access
resource "google_artifact_registry_repository_iam_member" "gke_reader" {
  for_each = toset(var.gke_service_accounts)

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${each.value}"
}

# CI/CD Push Access
resource "google_artifact_registry_repository_iam_member" "cicd_writer" {
  for_each = toset(var.cicd_service_accounts)

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${each.value}"
}

# Admin Access
resource "google_artifact_registry_repository_iam_member" "admins" {
  for_each = toset(var.admin_members)

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.admin"
  member = each.value
}
# Google Cloud documents the predefined Artifact Registry roles as the mechanism for controlling repository access, including repository-specific IAM access.
# https://docs.cloud.google.com/artifact-registry/docs/access-control
