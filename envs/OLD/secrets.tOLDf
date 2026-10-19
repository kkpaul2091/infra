
module "secret_manager" {
  source = "../../modules/secret_manager"

  env        = var.env
  project_id = var.project_id

  # Database
  db_host     = var.db_host
  db_port     = var.db_port
  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password

  # MongoDB
  mongodb_username = var.mongodb_username
  mongodb_password = var.mongodb_password
  mongodb_db_name  = var.mongodb_db_name
  mongodb_host     = var.mongodb_host
  mongodb_app_name = var.mongodb_app_name
}



