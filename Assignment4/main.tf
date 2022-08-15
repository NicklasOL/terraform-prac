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

variable "resource_group_name" {
  type = string
  default = "varitest"
}

variable "location" {
  type = string
  default = "west europe"
}

variable "vnet_name" {
  type = string
  default = "defaultVNET"
  
}

variable "vnet_address" {
  default = ["10.1.0.0/16"]
}

variable "subnet_name" {
  type = string
  default = "defaultSUBNET"
  validation {
    condition = length(var.subnet_name) > 3
    error_message = "Please keep the subnet name longer than 3 characters"
  }
}

variable "subnet_address" {
  default = ["10.1.0.0/24"]
}

resource "azurerm_resource_group" "varitestname" {
  name = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "pas" {
  name                = var.vnet_name
  address_space       = var.vnet_address
  location            = var.location
  resource_group_name = azurerm_resource_group.varitestname.name
}

resource "azurerm_subnet" "oppe" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.varitestname.name
  virtual_network_name = azurerm_virtual_network.pas.name
  address_prefixes     = var.subnet_address
}
