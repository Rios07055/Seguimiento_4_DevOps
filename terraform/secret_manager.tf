resource "google_secret_manager_secret" "db_password" {
  secret_id = "seguimiento-db-password"
  replication {
    auto { }
   }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret = google_secret_manager_secret.db_password.id
  secret_data = var.sql_db_password
}
