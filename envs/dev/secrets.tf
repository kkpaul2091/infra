resource "google_secret_manager_secret" "db_credentials" {
  secret_id = "myschool-${var.env}-allkey"

  replication {
    auto {}
  }

  labels = {
    env     = var.env
    project = var.project
  }
}

resource "google_secret_manager_secret_version" "db_credentials" {
  secret = google_secret_manager_secret.db_credentials.id

  secret_data = jsonencode({
    /*
    username = var.db_username
    password = var.db_password
    host     = var.db_host */
    # you can also hardcode the values here, but it's better to use variables for sensitive data
    rdsinstance = "mytestinstance.crskg446i66j.ap-southeast-2.rds.amazonaws.com"
    dbport = "3306"
    dbname = "MRPSKP"
    username = "admin"
    password = "SreMre34#"

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
    project = var.project
    type    = "mongodb"
  }
}

resource "google_secret_manager_secret_version" "mongodb_credentials" {
  secret = google_secret_manager_secret.mongodb_credentials.id

  secret_data = jsonencode({
    MONGODB_USERNAME = "kanupaul"
    MONGODB_PASSWORD = "QM3dbyJiqroKax7i"
    MONGODB_DB_NAME  = "mytododb"
    MONGODB_HOST     = "cluster0.mp3lyec.mongodb.net"
    MONGODB_APP_NAME = "Cluster0"
  })
}