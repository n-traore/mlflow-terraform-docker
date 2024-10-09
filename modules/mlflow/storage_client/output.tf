resource "time_sleep" "wait_20_seconds" {
  depends_on      = [docker_container.storage_client]
  create_duration = "20s"
}

data "local_file" "creds_file" {
  filename   = abspath("${path.root}/modules/mlflow/mounts/shares/creds_${var.minio_bucket}.txt")
  depends_on = [time_sleep.wait_20_seconds]
}

output "creds" {
  value      = flatten(split("\n", chomp(data.local_file.creds_file.content)))
  depends_on = [time_sleep.wait_20_seconds]
}
