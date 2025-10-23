resource "google_sql_database_instance" "sql_instance" {
  name = var.sql_instance_name
  project = var.gcp_project_id
  database_version = "POSTGRES_17"

  settings {
    tier = "db-perf-optimized-N-2"
    backup_configuration {
      enabled = true
    }

    ip_configuration {
      ipv4_enabled = true
      authorized_networks {
        name  = "all"
        value = "0.0.0.0/0"
      }
    }
  }
}
