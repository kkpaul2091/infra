project_id = "project-c2779828-d28b-45b8-810"
# project_id = project-4961abc8-49a2-4442-aef

location      = "australia-southeast2"
location_zone = "australia-southeast2-a"
/*
gke_service_accounts = [
  "myschool-dev-gke@project-4961abc8-49a2-4442-aef.iam.gserviceaccount.com"
]

cicd_service_accounts = [
  "myschool-dev-cicd@project-4961abc8-49a2-4442-aef.iam.gserviceaccount.com"
]

admin_members = [
  "group:platform-admins@example.com"
]
*/

env = "tst"

db_host = "mytestinstance.crskg446i66j.ap-southeast-2.rds.amazonaws.com"
db_port = "3306"
db_name = "MRPSKP"

#db_username = "..."
#db_password = "..."

mongodb_db_name  = "mytododb"
mongodb_host     = "cluster0.mp3lyec.mongodb.net"
mongodb_app_name = "Cluster0"
#mongodb_username = "..."
#mongodb_password = "..."

cluster_name = "my-school-cluster"


deletion_protection = false
release_channel     = "REGULAR"

node_pool_name     = "my-school-node-pool"
initial_node_count = 1

min_node_count = 1
max_node_count = 2

machine_type = "e2-standard-2"

disk_size_gb = 40
disk_type    = "pd-balanced"

node_labels = {
  environment = "dev"
  project     = "my-school"
  owner       = "shadana"
  workload    = "general"
  managed_by  = "terraform"
}

auto_repair  = true
auto_upgrade = true
