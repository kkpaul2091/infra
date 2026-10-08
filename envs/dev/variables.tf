variable "project_id" {
  type = string
}

variable "region" {
  type = string
  default     ="australia-southeast2"
}
variable "github_org" {
  type = string
  default     ="kkpaul2091"
}
variable "jwt_secret" {
  type = string
  default     ="kanu-shadana-mrema-srejoy-17-ascot-avenue-vale-park-sa-5081"
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