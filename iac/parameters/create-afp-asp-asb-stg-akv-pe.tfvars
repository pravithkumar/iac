app_name     = "frt"      
environment  = "dev"         
function_app_name = "afp-fortrea-eus-01"
location = "East US"
resource_group_name = "rg-fortrea-delete-01"
storage_account_name = "stgfortrea01"
storage_account_resource_group_name = "rg-fortrea-delete-01"
app_insights_name = "ai-fortres-eus-01"
app_insights_resource_group_name = "rg-fortrea-delete-01"
runtime = "python"
runtime_version = "3.9"
https_only = true
always_on = true
tags = {
  environment = "dev"
  project     = "function-app"
}

asp_resource_group_name = "rg-fortrea-delete-01"
asp_service_plan_name = "asp-fortrea-eus-01"
os_type = "Linux"
aspsku_name = "B1"
worker_count = 1

account_tier = "Standard"
account_replication_type = "LRS"

servicebus_name = "my-fortrea-servicebus-namespace"
sku = "Premium"
enable_managed_identity = true
public_network_access_enabled = false
trusted_services_allowed      = true

private_endpoints = [
  {
    name = "pe-function-app"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
    ]
    subresource_names = ["sites"]
  },
  {
    name = "pe-servicebus-namespace"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.servicebus.windows.net"
    ]
    subresource_names = ["namespace"]
  },
  {
    name = "pe-key-vault"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
    ]
    subresource_names = ["vault"]
  },
  {
    name = "pe-storageaccount1"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
    subresource_names = ["blob"]
  },
  {
    name = "pe-storageaccount2"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
    subresource_names = ["blob"]
  }
]

queue_names = ["queue1", "queue2"]
topic_names = ["topic1", "topic2"]
servicebus_capacity = 1
premium_messaging_partitions = 1
queue_max_size = 1024
topic_max_size = 1024
subscription_max_delivery_count = 10

api_management_name = "unique-api-management-name-2"
publisher_name = "Your Publisher Name"
publisher_email = "publisher@example.com"
api_sku = "Premium"
sku_count = "1"

key_vault_name = "kv-fortrea-eus-02"
kvsku_name = "standard"
kvpurge_protection_enabled = true
kvrbac_authorization = true
kvsoft_delete_retention_days = 7
enabled_for_deployment = false
enabled_for_disk_encryption = false
enabled_for_template_deployment = false
// public_network_access_enabled = false
kvnetdefaultaction = "Deny"
kvnetaclbypass = "AzureServices"
kvip_rules = ["124.56.78.91", "124.56.78.0/24"]
kvtimeoutcreate = "30m"
kvtimeoutupdate = "30m"
kvtimeoutdelete = "30m"

storage_accounts = [
  {
    name = "stgfortrea01"
    resource_group_name = "rg-fortrea-delete-01"
    location = "eastus"
    account_tier = "Standard"
    account_replication = "LRS"
    private_endpoint_name = "privateendpoint1"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    subresource_names = ["blob"]
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
    public_network_access_enabled = false
    https_traffic_only_enabled = true
    identity_type = "SystemAssigned"
    advanced_threat_protection_enabled = true
  },
  {
    name = "stgfortrea02"
    resource_group_name = "rg-fortrea-delete-01"
    location = "eastus"
    account_tier = "Standard"
    account_replication = "LRS"
    private_endpoint_name = "privateendpoint2"
    subnet_id = "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/virtualNetworks/vnet-fortrea-01/subnets/default"
    subresource_names = ["blob"]
    private_dns_zone_ids = [
      "/subscriptions/795783af-96d3-4629-9161-58de5577ed1e/resourceGroups/rg-fortrea-delete-01/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
    ]
    public_network_access_enabled = false
    https_traffic_only_enabled = true
    identity_type = "SystemAssigned"
    advanced_threat_protection_enabled = true
  }
]