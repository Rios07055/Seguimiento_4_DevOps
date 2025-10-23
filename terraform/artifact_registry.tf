resource "google_artifact_registry_repository" "repo" {
  project = var.gcp_project_id
  location = var.artifact_repo_location
  repository_id = var.artifact_repo_name
  format = "DOCKER"
  description   = "Repositorio para Seguimiento Facultad"
}
