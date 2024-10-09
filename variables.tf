variable "db_image" {
  description = "Database image to setup. For example, postgres:16.4 or mysql"
  type        = string
  default     = "postgres:16.4-alpine"
}

variable "db_user" {
  description = "Database container user's name"
  type        = string
}

variable "db_password" {
  description = "Database container user's password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database container name"
  type        = string
}

variable "db_provider_name" {
  description = "Database provider name, for example mysql (for MySQL database provider)"
  type        = string
  default     = "postgresql"
}

variable "mlflow_image_name" {
  description = "MLflow server docker image name"
  type        = string
  default     = "ml_tracking"
}

variable "mlflow_image_tags" {
  description = "Tag(s) to use for tagging MLflow server image. For example, tracking:1.0.0"
  type        = list(any)
  default     = ["tracking:0.0.1"]
}

variable "mlflow_container_name" {
  description = "MLflow server docker container name"
  type        = string
  default     = "ml_tracking"
}

variable "mlflow_tracking_port" {
  description = "MLflow tracking server port for ui and api calls"
  type        = string
  default     = "8090"
}

variable "storage_image" {
  description = "Storage image to setup. For example, minio/minio"
  type        = string
  default     = "minio/minio:RELEASE.2024-08-29T01-40-52Z-cpuv1"
}

variable "storage_container_name" {
  description = "Storage container name"
  type        = string
  default     = "artifacts-storage"
}

variable "storage_client_image" {
  description = "Storage client image that will run once to configure storage instance. For example, minio/mc"
  type        = string
  default     = "minio/mc:RELEASE.2024-08-26T10-49-58Z-cpuv1"
}

variable "storage_client_container_name" {
  description = "Storage client container name"
  type        = string
  default     = "minio-client"
}

variable "minio_user" {
  description = "Minio storage root user"
  type        = string
}

variable "minio_pw" {
  description = "Minio storage root password"
  type        = string
  sensitive   = true
}

variable "minio_bucket" {
  description = "Minio storage bucket name"
  type        = string
  default     = "mlflow"
}

variable "minio_bucket_region" {
  description = "Minio storage bucket region"
  type        = string
  default     = "eu-south-2"
}

