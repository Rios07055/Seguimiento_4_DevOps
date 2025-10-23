resource "google_storage_bucket" "bucket" {
  name = var.storage_bucket_name
  project = var.gcp_project_id
  location = var.gcp_region
  uniform_bucket_level_access = true
  versioning { enabled = false }
}
