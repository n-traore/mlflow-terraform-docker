resource "docker_image" "storage_client" {
  name = var.storage_client_image
}

resource "docker_container" "storage_client" {
  name  = var.storage_client_container_name
  image = docker_image.storage_client.image_id

  networks_advanced {
    name    = var.network
    aliases = ["${var.storage_client_container_name}"]
  }

  mounts {
    source    = abspath("${path.root}/modules/mlflow/mounts/shares")
    target    = "/shares"
    type      = "bind"
    read_only = false
  }

  restart  = "no"
  must_run = false

  entrypoint = [
    "sh",
    "-c",
    "mc alias set miniomlflow http://${var.storage_container_name}:9000 ${var.minio_user} ${var.minio_pw} && mc mb --ignore-existing --region=${var.minio_bucket_region} miniomlflow/${var.minio_bucket} && mc admin user svcacct add miniomlflow ${var.minio_user} > /shares/creds_${var.minio_bucket}.txt"
  ]
}
