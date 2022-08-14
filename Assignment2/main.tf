terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.2"
    }
  }
  required_version = "~>1.0"
}

provider "azurerm" {
    features {}

}

resource "azurerm_resource_group" "testheipaadeg" {
  name     = "myTFResourceGroup"
  location = "west europe"
  tags = {
    name = "jmkiodfsamkldsa"
  }
}

resource "azurerm_virtual_network" "pas" {
  name                = "pas-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.testheipaadeg.location
  resource_group_name = azurerm_resource_group.testheipaadeg.name
}

resource "azurerm_subnet" "oppe" {
  name                 = "oppe-subnet"
  resource_group_name  = azurerm_resource_group.testheipaadeg.name
  virtual_network_name = azurerm_virtual_network.pas.name
  address_prefixes     = ["10.0.1.0/24"]
}
