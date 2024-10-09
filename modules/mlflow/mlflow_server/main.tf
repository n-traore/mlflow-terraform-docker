resource "docker_image" "mlflow_server" {
  name = var.mlflow_image_name
  build {
    context = path.module
    tag     = var.mlflow_image_main_tags
  }
}

resource "docker_container" "mlflow_server" {
  name  = var.mlflow_container_name
  image = docker_image.mlflow_server.image_id

  networks_advanced {
    name    = var.network
    aliases = ["${var.mlflow_container_name}"]
  }

  env = [
    "MLFLOW_S3_ENDPOINT_URL=http://${var.storage_name}:9000",
    "MLFLOW_S3_IGNORE_TLS=true",
    "AWS_ACCESS_KEY_ID=${var.storage_access_key}",
    "AWS_SECRET_ACCESS_KEY=${var.storage_secret_key}"
  ]

  mounts {
    source    = abspath("${path.root}/modules/mlflow/mounts/mlflow_data")
    target    = "/app"
    type      = "bind"
    read_only = false
  }

  ports {
    internal = 8090
    external = 8090
  }

  restart = "unless-stopped"
  command = ["mlflow", "server", "--host", "0.0.0.0", "--port", "${var.mlflow_tracking_port}", "--backend-store-uri", "${var.db_provider_name}://${var.db_user}:${var.db_password}@${var.db_container_name}:5432/${var.db_name}", "--default-artifact-root", "s3://${var.storage_bucket_name}"]
}