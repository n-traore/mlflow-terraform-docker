variable "storage_client_image" {
  description = "Storage client image that will run once to configure storage instance. For example, minio/mc"
  type        = string
}

variable "storage_client_container_name" {
  description = "Storage client container name"
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

variable "minio_bucket" {
  description = "Minio storage bucket name"
  type        = string
}

variable "minio_bucket_region" {
  description = "Minio storage bucket region"
  type        = string
}

variable "network" {
  description = "Docker container network"
  type        = string
}