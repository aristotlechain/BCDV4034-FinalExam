provider "azurerm" {
  features {}
  subscription_id = "7b0a02df-610c-494c-9d32-e5883372662e"
}

resource "azurerm_resource_group" "rg" {
  name     = "aks-tf-rg"
  location = "Canada Central"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-tf-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-tf"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2as_v4"
  }

  identity {
    type = "SystemAssigned"
  }

  storage_profile {
    blob_driver_enabled             = true
    disk_driver_enabled             = true
    file_driver_enabled             = true
    snapshot_controller_enabled     = true
  }

  tags = {
    environment = "terraform-demo"
  }
}

