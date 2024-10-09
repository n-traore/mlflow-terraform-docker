output "storage_container_network" {
  value = docker_container.storage.network_data
}

output "storage_container_name" {
  value = docker_container.storage.name
}

output "storage_container_port" {
  value = docker_container.storage.ports
}
