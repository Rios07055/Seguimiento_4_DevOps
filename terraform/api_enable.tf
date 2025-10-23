resource "google_project_service" "enable_apis" {
  for_each = toset([
    "artifactregistry.googleapis.com",
    "run.googleapis.com",
    "sqladmin.googleapis.com",
    "storage.googleapis.com",
    "secretmanager.googleapis.com"
  ])
  project = var.gcp_project_id
  service = each.key
}
