module "db" {
  source      = "./modules/mlflow/db/postgres"
  network     = docker_network.network.name
  db_image    = var.db_image
  db_user     = var.db_user
  db_password = var.db_password
  db_name     = var.db_name
}

module "storage" {
  source                 = "./modules/mlflow/storage"
  network                = docker_network.network.name
  storage_image          = var.storage_image
  storage_container_name = var.storage_container_name
  minio_user             = var.minio_user
  minio_pw               = var.minio_pw
}

resource "time_sleep" "wait_15_seconds" {
  depends_on      = [module.storage]
  create_duration = "15s"
}

module "storage_client" {
  source                        = "./modules/mlflow/storage_client"
  network                       = docker_network.network.name
  storage_client_image          = var.storage_client_image
  storage_client_container_name = var.storage_client_container_name
  storage_container_name        = module.storage.storage_container_name
  minio_user                    = var.minio_user
  minio_pw                      = var.minio_pw
  minio_bucket                  = var.minio_bucket
  minio_bucket_region           = var.minio_bucket_region
  depends_on                    = [time_sleep.wait_15_seconds]
}

module "tracking" {
  source                 = "./modules/mlflow/mlflow_server"
  network                = docker_network.network.name
  storage_name           = module.storage.storage_container_name
  storage_bucket_name    = var.minio_bucket
  storage_access_key     = local.mlflow_bucket_access_key
  storage_secret_key     = local.mlflow_bucket_secret_key
  db_container_name      = module.db.container_name
  mlflow_image_name      = var.mlflow_image_name
  mlflow_image_main_tags = var.mlflow_image_tags
  mlflow_container_name  = var.mlflow_container_name
  mlflow_tracking_port   = var.mlflow_tracking_port
  db_provider_name       = var.db_provider_name
  db_user                = var.db_user
  db_password            = var.db_password
  db_name                = var.db_name
  depends_on             = [module.storage_client, module.db]
}
