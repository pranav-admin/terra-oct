terraform {
  backend "azurerm" {
    tenant_id = "cabf5d06-7e3a-4d14-b7f4-2b5819ed881e"
    client_id       = "8bd790d8-e09c-4d65-b08d-cbae02d04a46"
    storage_account_name = "pranavterrabackup"
    container_name       = "tfstate"
    key = "terraform.tfstate"
    resource_group_name = "pranav-terra-backend"
    subscription_id = "2df30ff1-915d-4d35-974a-3d3155aaa413"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.48.0"
    }
  }
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}


