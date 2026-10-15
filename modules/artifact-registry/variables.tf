variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "location" {
  description = "Artifact Registry location"
  type        = string
  default     = "australia-southeast2"
}

variable "repository_id" {
  description = "Artifact Registry repository ID"
  type        = string
}

variable "description" {
  description = "Description of the Artifact Registry repository"
  type        = string
  default     = "Docker repository"
}

variable "format" {
  description = "Artifact Registry repository format"
  type        = string
  default     = "DOCKER"
}

variable "gke_service_accounts" {
  description = "Service accounts requiring pull access"
  type        = list(string)
  default     = []
}

variable "cicd_service_accounts" {
  description = "Service accounts requiring push access"
  type        = list(string)
  default     = []
}

variable "admin_members" {
  description = "Members requiring Artifact Registry admin access"
  type        = list(string)
  default     = []
}
