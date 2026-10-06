variable "project_id" {
  type = string
}

variable "region" {
  type = string
}
variable "github_org" {
  type = string
}
variable "jwt_secret" {
  type = string
}
variable "env" {
  description = "Environment name (dev, qa, prod)"
  type        = string
  default     = "tst"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "myschool"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "SreMre34#"
}

variable "gke_service_accounts" {
  description = "Service accounts used by GKE nodes"
  type        = list(string)
  default     = []
}

variable "cicd_service_accounts" {
  description = "CI/CD service accounts"
  type        = list(string)
  default     = []
}

variable "admin_members" {
  description = "Artifact Registry administrators"
  type        = list(string)
  default     = []
}

/*
Artifact Registry
│
├── GKE Nodes
│     └── Reader
│
├── GitHub Actions
│     └── Writer
│
├── ArgoCD
│     └── Reader
│
└── Platform Team
      └── Admin
*/