variable "env" {
  description = "Environment name"
  type        = string
}

variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

# =========================
# Database variables
# =========================

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = string
  default     = "3306"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}


# =========================
# MongoDB variables
# =========================

variable "mongodb_username" {
  description = "MongoDB username"
  type        = string
  sensitive   = true
}

variable "mongodb_password" {
  description = "MongoDB password"
  type        = string
  sensitive   = true
}

variable "mongodb_db_name" {
  description = "MongoDB database name"
  type        = string
}

variable "mongodb_host" {
  description = "MongoDB host"
  type        = string
}

variable "mongodb_app_name" {
  description = "MongoDB application name"
  type        = string
  default     = "Cluster0"
}
