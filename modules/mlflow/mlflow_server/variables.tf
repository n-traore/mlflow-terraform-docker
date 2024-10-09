variable "mlflow_image_name" {
  description = "MLflow server docker image name"
  type        = string
}

variable "mlflow_image_main_tags" {
  description = "Main tag to use for tagging MLflow server image. For example, tracking:1.0.0"
  type        = list(any)
}

variable "mlflow_container_name" {
  description = "MLflow server docker container name"
  type        = string
}

variable "mlflow_tracking_port" {
  description = "MLflow tracking server port for ui and api calls"
  type        = string
}

variable "storage_name" {
  description = "Storage container name"
  type        = string
}

variable "storage_bucket_name" {
  description = "Storage bucket name"
  type        = string
}

variable "storage_access_key" {
  description = "Storage bucket access key"
  type        = string
  sensitive   = true
}

variable "storage_secret_key" {
  description = "Storage bucket secret key"
  type        = string
  sensitive   = true
}

variable "network" {
  description = "Docker container network"
  type        = string
}

variable "db_provider_name" {
  description = "Database provider name, for example mysql (for MySQL database provider)"
  type        = string
}

variable "db_container_name" {
  description = "Database container name, created by db module"
  type        = string
}

variable "db_user" {
  description = "Database container user's name"
  type        = string
  sensitive   = true
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