app_name     = "fort"      
environment  = "dev"       
location_test = "eus"
location = "East US"

app_insights_name = "ai-fort-dev-eus-01"
app_insights_resource_group_name = "rg-fort-dev-eus-001"

runtime = "python"
runtime_version = "3.9"
https_only = true
always_on = true
tags = {
  environment = "dev"
  project     = "function-app"
}


os_type = "Linux"
aspsku_name = "B1"
worker_count = 1

account_tier = "Standard"
account_replication_type = "LRS"


sku = "Premium"
enable_managed_identity = true
public_network_access_enabled = false
trusted_services_allowed      = true


queue_names = ["queue1", "queue2"]
topic_names = ["topic1", "topic2"]
servicebus_capacity = 1
premium_messaging_partitions = 1
queue_max_size = 1024
topic_max_size = 1024
subscription_max_delivery_count = 10




kvsku_name = "standard"
kvpurge_protection_enabled = true
kvrbac_authorization = true
kvsoft_delete_retention_days = 7
enabled_for_deployment = false
enabled_for_disk_encryption = false
enabled_for_template_deployment = false
kvnetdefaultaction = "Deny"
kvnetaclbypass = "AzureServices"
kvip_rules = ["124.56.78.91", "124.56.78.0/24"]
kvtimeoutcreate = "30m"
kvtimeoutupdate = "30m"
kvtimeoutdelete = "30m"



private_endpoint_name = "privateendpoint2"


https_traffic_only_enabled = true
identity_type = "SystemAssigned"
advanced_threat_protection_enabled = true


