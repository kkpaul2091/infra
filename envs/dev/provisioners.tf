# Create a Null Resource and Provisioners
resource "null_resource" "gke_info" {
  provisioner "local-exec" {
    command     = <<-EOT
    echo "GKE Cluster Name: ${module.gke.cluster_name}  created on: $(date '+%a %b %d %I:%M:%S %p %Z %Y') " >> gke-info.txt
  EOT
    working_dir = "local-exec-output-files/"
  }
}