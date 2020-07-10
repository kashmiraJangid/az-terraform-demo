resource "random_pet" "prefix" {}

variable "aksServicePrincipalAppId" {
}

variable "aksServicePrincipalPassword" {
}

provider "azurerm" {
  version = "~> 2.16.0"
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${random_pet.prefix.id}-rg"
  location = "West Europe"

  tags = {
    environment = "Demo"
  }
}

# Public IP
data "azurerm_public_ip" "default" {
  name                = "public-ip-for-demo"
  resource_group_name = "public-ip-resource-group"
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

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

  network_profile {
    network_plugin     = "kubenet"
    load_balancer_sku  = "Standard"

    load_balancer_profile {
      outbound_ip_address_ids = [ "${data.azurerm_public_ip.default.id}" ]
    }
  }

  depends_on = [data.azurerm_public_ip.default]
}
