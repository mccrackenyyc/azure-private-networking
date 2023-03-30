terraform {
  backend "local" {
    path = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.40.0"
      #hardcode to latest version available then remove this comment
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id

  features {}
}