# =========================
# Database Secret
# =========================

resource "google_secret_manager_secret" "db_credentials" {
  secret_id = "myschool-${var.env}-allkey"

  replication {
    auto {}
  }

  labels = {
    env     = var.env
    project = var.project_id
    type    = "database"
  }
}

resource "google_secret_manager_secret_version" "db_credentials" {
  secret = google_secret_manager_secret.db_credentials.id

  secret_data = jsonencode({
    rdsinstance = var.db_host
    dbport      = var.db_port
    dbname      = var.db_name
    username    = var.db_username
    password    = var.db_password
  })
}


# =========================
# MongoDB Secret
# =========================

resource "google_secret_manager_secret" "mongodb_credentials" {
  secret_id = "myschool-${var.env}-mongodb"

  replication {
    auto {}
  }

  labels = {
    env     = var.env
    project = var.project_id
    type    = "mongodb"
  }
}

resource "google_secret_manager_secret_version" "mongodb_credentials" {
  secret = google_secret_manager_secret.mongodb_credentials.id

  secret_data = jsonencode({
    MONGODB_USERNAME = var.mongodb_username
    MONGODB_PASSWORD = var.mongodb_password
    MONGODB_DB_NAME  = var.mongodb_db_name
    MONGODB_HOST     = var.mongodb_host
    MONGODB_APP_NAME = var.mongodb_app_name
  })
}
