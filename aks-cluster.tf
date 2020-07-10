//resource "random_pet" "prefix" {}

variable "aksServicePrincipalAppId" {
}

variable "aksServicePrincipalPassword" {
}

variable "aksBaseName" {}

provider "azurerm" {
  version = "~> 2.16.0"
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${var.aksBaseName}-rg"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.aksBaseName}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${var.aksBaseName}-k8s"

  default_node_pool {
      name       = "default"
      node_count = 1
      vm_size    = "Standard_D2_v2"
  }

  service_principal {
    client_id     = var.aksServicePrincipalAppId
    client_secret = var.aksServicePrincipalPassword
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}

output "resource_group_name" {
  value = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  value = azurerm_kubernetes_cluster.default.name
}
