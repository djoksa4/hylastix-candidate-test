terraform {
  required_version = ">= 1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.45.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstatestorageaccount44"
    container_name       = "tfstate"
    key                  = "hylastix-candidate-test/infra.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id                 = var.subscription_id
  resource_provider_registrations = "none"
}

resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.region
}
