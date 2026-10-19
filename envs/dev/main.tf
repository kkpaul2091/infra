# VPC
module "vpc" {
  source = "../../modules/vpc"

  project_id = var.project_id
  vpc_name   = "myschool-vpc"

  routing_mode = "REGIONAL"

  subnets = {
    myschool-gke-subnet = {
      region        = "australia-southeast2"
      ip_cidr_range = "10.10.0.0/20"

      private_ip_google_access = true

      secondary_ip_ranges = [
        {
          range_name    = "gke-pods"
          ip_cidr_range = "10.20.0.0/16"
        },
        {
          range_name    = "gke-services"
          ip_cidr_range = "10.30.0.0/20"
        }
      ]
    }

    myschool-db-subnet = {
      region        = "australia-southeast2"
      ip_cidr_range = "10.40.0.0/24"

      private_ip_google_access = true
    }
  }
}
# Secret Manager

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

# Artifact Registry

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

# GKE
module "gke" {
  source = "../../modules/gke"

  project_id = var.project_id
  network    = module.vpc.vpc_name
  subnetwork = module.vpc.subnets["myschool-gke-subnet"].name

  pods_range_name     = "gke-pods"
  services_range_name = "gke-services"

  cluster_name = var.cluster_name
  location     = var.location_zone

  deletion_protection = var.deletion_protection
  release_channel     = var.release_channel

  node_pool_name     = var.node_pool_name
  initial_node_count = var.initial_node_count
  min_node_count     = var.min_node_count
  max_node_count     = var.max_node_count

  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
  disk_type    = var.disk_type

  node_labels = var.node_labels

  auto_repair  = var.auto_repair
  auto_upgrade = var.auto_upgrade


}

