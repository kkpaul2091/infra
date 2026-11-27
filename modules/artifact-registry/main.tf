
# Artifact Registry Repository
resource "google_artifact_registry_repository" "docker_repo" {
  for_each = toset(var.repositories)
  project       = var.project_id
  location      = var.location  
  repository_id = each.value
  description   = "${each.value} Docker repository"  
  format        = var.format
}

locals {
  gke_repo_access = {
    for pair in setproduct(
      var.repositories,
      var.gke_service_accounts
    ) :
    "${pair[0]}-${pair[1]}" => {
      repository      = pair[0]
      service_account = pair[1]
    }
  }

  cicd_repo_access = {
    for pair in setproduct(
      var.repositories,
      var.cicd_service_accounts
    ) :
    "${pair[0]}-${pair[1]}" => {
      repository      = pair[0]
      service_account = pair[1]
    }
  }

  admin_repo_access = {
    for pair in setproduct(
      var.repositories,
      var.admin_members
    ) :
    "${pair[0]}-${pair[1]}" => {
      repository = pair[0]
      member     = pair[1]
    }
  }
}

# GKE Pull Access
resource "google_artifact_registry_repository_iam_member" "gke_reader" {
  for_each = local.gke_repo_access

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo[each.value.repository].repository_id

  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${each.value.service_account}"
}

# CI/CD Push Access
resource "google_artifact_registry_repository_iam_member" "cicd_writer" {
  for_each = local.cicd_repo_access

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo[each.value.repository].repository_id

  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${each.value.service_account}"
}

# Admin Access
resource "google_artifact_registry_repository_iam_member" "admins" {
  for_each = local.admin_repo_access

  project    = var.project_id
  location   = var.location
  repository = google_artifact_registry_repository.docker_repo[each.value.repository].repository_id

  role   = "roles/artifactregistry.admin"
  member = each.value.member
}

# Google Cloud documents the predefined Artifact Registry roles as the mechanism for controlling repository access, including repository-specific IAM access.
# https://docs.cloud.google.com/artifact-registry/docs/access-control


/*
# Artifact Registry Repository
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
*/