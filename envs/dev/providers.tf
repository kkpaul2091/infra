terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
 
  backend "gcs" {
    bucket = "kkp-myschool-tfstate"
    prefix = "myschool-gke-dev"
  }

}

provider "google" {
  project = var.project_id
  region  = "australia-southeast2"
  zone    = "australia-southeast2-a"
}