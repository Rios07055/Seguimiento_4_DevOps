resource "google_service_account" "run_sa" {
  account_id = "${var.app_service_name}-sa"
  project = var.gcp_project_id
  display_name = var.app_service_name
}

resource "google_project_iam_member" "run_sa_cloudsql" {
  project = var.gcp_project_id
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.run_sa.email}"
}

resource "google_artifact_registry_repository_iam_member" "run_sa_artifact_reader" {
  project    = var.gcp_project_id
  location   = var.artifact_repo_location
  repository = google_artifact_registry_repository.repo.repository_id
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.run_sa.email}"
}

resource "google_project_iam_member" "allow_deployer_to_impersonate_run_sa" {
  project = var.gcp_project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "user:rios07055@gmail.com"
}


resource "google_project_iam_member" "run_sa_token_creator" {
  project = var.gcp_project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.run_sa.email}"
}

resource "google_cloud_run_service_iam_member" "invoker" {
  service  = google_cloud_run_service.app.name
  location = google_cloud_run_service.app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
  count = var.enable_public_invoker ? 1 : 0
}

