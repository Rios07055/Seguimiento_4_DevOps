output "artifact_repo_full_name" {
  value = google_artifact_registry_repository.repo.name
}

output "storage_bucket_url" {
  value = google_storage_bucket.bucket.url
}

output "cloud_run_url" {
  value = try(google_cloud_run_service.app.status[0].url, "")
}

output "sql_instance_connection_name" {
  value = google_sql_database_instance.sql_instance.connection_name
}
