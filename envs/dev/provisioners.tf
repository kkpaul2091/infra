# Create a Null Resource and Provisioners
resource "null_resource" "gke_info" {
  provisioner "local-exec" {
    command     = <<-EOT
    echo "GKE Cluster Name: ${google_container_cluster.my_school_cluster.name}  created on: $(date '+%a %b %d %I:%M:%S %p %Z %Y') " >> gke-info.txt
  EOT
    working_dir = "local-exec-output-files/"
  }
}