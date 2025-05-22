# Application Naming and Environment
app_name                           = "aip"
environment                        = "dev"
region                             = "eus"
location                           = "East US"

# Tags
tags = {
  ApplicationName                  = "Azure Integration Platform"
  BusinessUnit                     = "Data & Tech: Informatics"
  CI                               =  "TBD"
  CostCenter                       = "8855"
  Environment                      =  "NON-PROD"
  ITApplicationOwner               = "Diarmaid O’Reilly"
  ITCostowner                      = "Alaric Jackson"
}


# Function App
runtime                            = "java"
runtime_version                    = "11"
always_on                          = true
tenant_auth_endpoint               = "https://login.microsoftonline.com/5fbc2afc-b6e7-49ed-a6cf-ea49a27f7c12/v2.0/"
client_id                          = "ea05543f-733f-43fd-bbe2-857a99c1f2aa"
allowed_external_redirect_urls     = ["openid", "profile", "email"]

# App Service Plan
os_type                            = "Linux"
aspsku_name                        = "I1v2"
worker_count                       = 1

# Storage
account_tier                       = "Standard"
account_replication_type           = "LRS"

# Service Bus
sku                                = "Premium"
queue_names                        = ["queue1", "queue2"]
topic_names                        = ["topic1", "topic2"]
servicebus_capacity                = 1
premium_messaging_partitions       = 1
queue_max_size                     = 1024
topic_max_size                     = 1024
subscription_max_delivery_count    = 10

# Other Settings (Potentially for other resources)
// identity_type                      = "SystemAssigned"

# api managment
publisher_name                     = "Your Publisher Name"
publisher_email                    = "publisher@example.com"
api_sku                            = "Standard"
sku_count                          = 1

security_configuration = [
  {
  backend_ssl30_enabled = true
  backend_tls10_enabled = false
  backend_tls11_enabled  = false
  frontend_ssl30_enabled = true
  frontend_tls10_enabled = false
  frontend_tls11_enabled = false
}
]

# app service environment

internal_load_balancing_mode       = "Web, Publishing"  
disable_tls1_0 = 1 
frontend_ssl_cipher_suite_order    = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"

