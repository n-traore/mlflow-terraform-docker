resource "docker_network" "network" {
  name   = "mlflow_network"
  driver = "bridge"
}
