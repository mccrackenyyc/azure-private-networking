locals {
  networks = {
   "headoffice" = {
    "vnet" = ["10.1.0.0/16"]
    "subnet" = ["10.1.1.0/24"]
   }
   "remoteoffice" = {
    "vnet" = ["10.2.0.0/16"]
    "subnet" = ["10.2.1.0/24"]
   }
  }
}