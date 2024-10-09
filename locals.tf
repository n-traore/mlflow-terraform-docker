locals {
  mlflow_bucket_access_key = [for v in module.storage_client.creds : trimspace(regex("^.*\\:(.*)", v)[0]) if strcontains(v, "Access")][0]
  mlflow_bucket_secret_key = [for v in module.storage_client.creds : trimspace(regex("^.*\\:(.*)", v)[0]) if strcontains(v, "Secret")][0]
}
