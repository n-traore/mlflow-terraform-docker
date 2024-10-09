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

resource "docker_container" "mysql" {
  name  = "postgres"
  image = docker_image.db.image_id

  networks_advanced {
    name    = var.network
    aliases = ["mysql"]
  }

  env = [
    "MYSQL_ONETIME_PASSWORD=yes",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}"
  ]

  mounts {
    source = abspath(local_file.init_sql.filename)
    target = "/docker-entrypoint-initdb.d/init.sql"
    type   = "bind"
  }

  volumes {
    host_path      = "/var/lib/docker/volumes/mysql_data"
    container_path = "/var/lib/mysql"
    volume_name    = "postgres_data"
  }

  ports {
    internal = 3306
    external = 3306
  }

  restart = "unless-stopped"
}
