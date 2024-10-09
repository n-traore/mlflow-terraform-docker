resource "docker_image" "storage" {
  name = var.storage_image
}

resource "docker_container" "storage" {
  name  = var.storage_container_name
  image = docker_image.storage.image_id

  networks_advanced {
    name    = var.network
    aliases = ["${var.storage_container_name}"]
  }

  env = [
    "MINIO_ROOT_USER=${var.minio_user}",
    "MINIO_ROOT_PASSWORD=${var.minio_pw}"
  ]

  volumes {
    host_path      = "/var/lib/docker/volumes/minio_data"
    container_path = "/data/minio"
    volume_name    = "minio_data"
  }

  ports {
    internal = 9000
    external = 9000
  }

  ports {
    internal = 9100
    external = 9100
  }

  restart = "unless-stopped"
  command = ["minio", "server", "/data/minio", "--console-address", ":9100"]
}
