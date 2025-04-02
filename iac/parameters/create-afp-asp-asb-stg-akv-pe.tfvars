app_name = "fort"
environment = "dev"
location_test = "eus"
location = "East US"

tags = {
  environment = "dev"
  project = "function-app"
}

# App insights
app_insights_name = "ai-fort-dev-eus-01"
app_insights_resource_group_name = "rg-fort-dev-eus-001"

# Function App
runtime = "python"
runtime_version = "3.9"
https_only = true
always_on = true

# App Service Plan
os_type = "Linux"
aspsku_name = "B1"
worker_count = 1

# Storage
account_tier = "Standard"
account_replication_type = "LRS"

# SerVice Bus
sku = "Premium"
enable_managed_identity = true
queue_names = ["queue1", "queue2"]
topic_names = ["topic1", "topic2"]
servicebus_capacity = 1
premium_messaging_partitions = 1
queue_max_size = 1024
topic_max_size = 1024
subscription_max_delivery_count = 10


identity_type = "SystemAssigned"
