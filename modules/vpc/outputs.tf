output "vpc_id" {
  description = "VPC network ID"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "VPC network name"
  value       = google_compute_network.vpc.name
}

output "vpc_self_link" {
  description = "VPC self link"
  value       = google_compute_network.vpc.self_link
}


output "subnets" {
  description = "Created subnet information"

  value = {
    for name, subnet in google_compute_subnetwork.subnets : name => {
      id            = subnet.id
      name          = subnet.name
      region        = subnet.region
      ip_cidr_range = subnet.ip_cidr_range
      network       = subnet.network
      self_link     = subnet.self_link
    }
  }
}