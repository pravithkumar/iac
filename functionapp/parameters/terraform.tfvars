app_name                           = "fort"
environment                        = "dev"
location_test                      = "eus"
location                           = "East US"

# Tags
tags = {
  ApplicationName                  = "Azure Integration Platform"
  BusinessUnit                     = "CTO"
  CI                               =  ""
  CostCenter                       = "8855 Data & Tech: Informatics"
  Environment                      =  ""
  ITApplicationOwner               = "Diarmaid O’Reilly"
  ITCostowner                      = "Diarmaid O’Reilly"
}

# Function App
runtime                            = "python"
runtime_version                    = "3.9"
always_on                          = true
tenant_auth_endpoint               = "Tenant authentication endpoint"
client_id                          = "cfe072e8-149a-4a79-b7d6-9df55eb4aa6b"
allowed_external_redirect_urls     = ["openid", "profile", "email"]

# App Service Plan
os_type                            = "Linux"
aspsku_name                        = "B1"
worker_count                       = 1

# Storage
account_tier                       = "Standard"
account_replication_type           = "LRS"