variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "location" {
  description = "GCP zone or region for the GKE cluster"
  type        = string
}

variable "deletion_protection" {
  description = "Enable deletion protection for the GKE cluster"
  type        = bool
  default     = false
}

variable "release_channel" {
  description = "GKE release channel"
  type        = string
  default     = "REGULAR"
}

variable "node_pool_name" {
  description = "Name of the GKE node pool"
  type        = string
}

variable "initial_node_count" {
  description = "Initial number of nodes"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes"
  type        = number
  default     = 2
}

variable "machine_type" {
  description = "Machine type for GKE nodes"
  type        = string
  default     = "e2-standard-2"
}

variable "disk_size_gb" {
  description = "Disk size for GKE nodes"
  type        = number
  default     = 40
}

variable "disk_type" {
  description = "Disk type for GKE nodes"
  type        = string
  default     = "pd-balanced"
}

variable "node_labels" {
  description = "Labels applied to GKE nodes"
  type        = map(string)
  default     = {}
}

variable "auto_repair" {
  description = "Enable automatic node repair"
  type        = bool
  default     = true
}

variable "auto_upgrade" {
  description = "Enable automatic node upgrades"
  type        = bool
  default     = true
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "network" {
  description = "VPC network used by the GKE cluster"
  type        = string
}

variable "subnetwork" {
  description = "VPC subnetwork used by the GKE cluster"
  type        = string
}

variable "pods_range_name" {
  description = "Secondary IP range name for GKE Pods"
  type        = string
}

variable "services_range_name" {
  description = "Secondary IP range name for GKE Services"
  type        = string
}