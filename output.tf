output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}

output "cluster_username" {
    value = azurerm_kubernetes_cluster.default.kube_config.0.username
}

output "cluster_password" {
    value = azurerm_kubernetes_cluster.default.kube_config.0.password
}

output "kube_config" {
    value = azurerm_kubernetes_cluster.default.kube_config_raw
}

output "host" {
    value = azurerm_kubernetes_cluster.default.kube_config.0.host
}

output "public_ip_address" {
  value = data.azurerm_public_ip.default.ip_address
}