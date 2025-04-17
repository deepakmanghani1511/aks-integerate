provider "azurerm" {
  features {}
  subscription_id = "80725b9c-38b3-402c-872fec66539e39d9"
}

resource "azurerm_resource_group" "main" {
  name     = "rg-integrated-aks-deep"
  location = "East US 2"
}

resource "azurerm_container_registry" "acr" {
  name                = "deepak941"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-integrated-deep"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "dotnetaks"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }
}
