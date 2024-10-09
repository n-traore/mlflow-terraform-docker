variable "storage_image" {
  description = "Storage image to setup. For example, minio/minio"
  type        = string
}

variable "storage_container_name" {
  description = "Storage container name"
  type        = string
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

variable "network" {
  description = "Docker container network"
  type        = string
}