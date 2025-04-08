# Application Naming and Environment
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

# App Insights
app_insights_name                  = "appinsights-int-esu-001"
app_insights_resource_group_name   = "rg-int-apps-esu-003"

# Function App
runtime                            = "python"
runtime_version                    = "3.9"
always_on                          = true

# App Service Plan
os_type                            = "Linux"
aspsku_name                        = "B1"
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
publisher_name = "Your Publisher Name"
publisher_email = "publisher@example.com"
api_sku = "Premium"
sku_count = 1

# app service environment

internal_load_balancing_mode  = "Web, Publishing"  
disable_tls1_0 = 1 
frontend_ssl_cipher_suite_order = "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"
