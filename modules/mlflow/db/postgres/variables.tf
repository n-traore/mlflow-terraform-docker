variable "db_image" {
  description = "Database image to setup. For example, postgres:16.4 or mysql"
  type        = string
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

variable "network" {
  description = "Docker container network"
  type        = string
}