variable "gcp_project_id" {
  type = string
}

variable "gcp_region" {
  type = string
}

variable "gcp_zone" {
  type = string
}

variable "artifact_repo_location" {
  type = string
}

variable "artifact_repo_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "container_image" {
  type = string
}

variable "sql_instance_name" {
  type = string
}

variable "sql_db_name" {
  type = string
}

variable "sql_db_user" {
  type = string
}

variable "sql_db_password" {
  type      = string
  sensitive = true
}

variable "storage_bucket_name" {
  type = string
}

variable "enable_public_invoker" {
  type    = bool
  default = false
}

