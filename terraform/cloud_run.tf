resource "google_cloud_run_service" "app" {
  name     = "seguimiento-facultad-v1"
  location = "us-central1"

  depends_on = [
    google_project_service.enable_apis["run.googleapis.com"],
    google_project_service.enable_apis["artifactregistry.googleapis.com"],
    google_artifact_registry_repository.repo
  ]

  template {
    metadata {
      annotations = {
        "run.googleapis.com/cloudsql-instances" = "${var.gcp_project_id}:us-central1:${google_sql_database_instance.sql_instance.name}"
      }
    }

    spec {

      service_account_name = google_service_account.run_sa.email

      containers {
        image = var.container_image

        env {
          name  = "SPRING_DATASOURCE_URL"
          value = "jdbc:postgresql:///seguimiento_db?cloudSqlInstance=primal-fulcrum-475820-s6:us-central1:seguimiento-postgres&socketFactory=com.google.cloud.sql.postgres.SocketFactory"
        }

        env {
          name  = "SPRING_DATASOURCE_USERNAME"
          value = var.sql_db_user
        }

        env {
          name  = "SPRING_DATASOURCE_PASSWORD"
          value = var.sql_db_password
        }

        env {
          name  = "DB_NAME"
          value = var.sql_db_name
        }

        env {
          name  = "SPRING_JPA_HIBERNATE_DDL_AUTO"
          value = "update"
        }

      }
    }
  }


  traffic {
    percent = 100
    latest_revision = true
  }
}
