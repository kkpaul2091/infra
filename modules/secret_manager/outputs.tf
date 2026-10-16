output "db_secret_id" {
  description = "Database Secret Manager secret ID"
  value       = google_secret_manager_secret.db_credentials.secret_id
}

output "db_secret_name" {
  description = "Database Secret Manager resource name"
  value       = google_secret_manager_secret.db_credentials.name
}

output "mongodb_secret_id" {
  description = "MongoDB Secret Manager secret ID"
  value       = google_secret_manager_secret.mongodb_credentials.secret_id
}

output "mongodb_secret_name" {
  description = "MongoDB Secret Manager resource name"
  value       = google_secret_manager_secret.mongodb_credentials.name
}
