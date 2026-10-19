module "artifact_registry" {
  source = "../../modules/artifact-registry"

  project_id    = var.project_id
  location      = var.location
  repository_id = "my-school-repo"

  description = "Docker repository for My School application images"

  gke_service_accounts = var.gke_service_accounts

  cicd_service_accounts = var.cicd_service_accounts

  admin_members = var.admin_members
}
/*
resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.project_id
  location      = "australia-southeast2"
  repository_id = "my-school-repo"
  description   = "Docker repository for My School application images"
  format        = "DOCKER"
}

# GKE Pull Access
resource "google_artifact_registry_repository_iam_member" "gke_reader" {
  for_each = toset(var.gke_service_accounts)

  project    = var.project_id
  location   = "australia-southeast2" #var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${each.value}"
}

# CI/CD Push Access
resource "google_artifact_registry_repository_iam_member" "cicd_writer" {
  for_each = toset(var.cicd_service_accounts)

  project    = var.project_id
  location   = "australia-southeast2" #var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${each.value}"
}

# Admin Access
resource "google_artifact_registry_repository_iam_member" "admins" {
  for_each = toset(var.admin_members)

  project    = var.project_id
  location   = "australia-southeast2" # var.location
  repository = google_artifact_registry_repository.docker_repo.repository_id

  role   = "roles/artifactregistry.admin"
  member = each.value
}
*/