resource "local_file" "init_sql" {
  content = templatefile("${path.module}/sql/init.tftpl", {
    db_name = "${var.db_name}",
    db_user = "${var.db_user}"
  })
  filename = "${path.module}/sql/init.sql"
}

resource "docker_image" "db" {
  name = var.db_image
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.db.image_id

  networks_advanced {
    name    = var.network
    aliases = ["postgres"]
  }

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  mounts {
    source = abspath(local_file.init_sql.filename)
    target = "/docker-entrypoint-initdb.d/init.sql"
    type   = "bind"
  }

  volumes {
    host_path      = "/var/lib/docker/volumes/postgres_data"
    container_path = "/var/lib/postgresql/data"
    volume_name    = "postgres_data"
  }

  ports {
    internal = 5432
    external = 5432
  }

  restart = "unless-stopped"
}