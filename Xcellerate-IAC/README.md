# Deploying Xcellerate Modernization Infrastructure using Terraform

## Overview

Deploying Xcellerate Modernization Infrastructure

## Directory Structure

- **environments/**: The directory contains environment wise settings file.
    - **dev/**: Contains files for deploying the resoureces in development environment.
    - **prod/**: Contains files for deployong the resources in production environment.
- **modules/**: The directory contains modules for creating resources.
- **pipelines/**: The directory contains Pipeline files of the project.
- **templates/**: The directory contains template files used in pipeline file.

## Directory Description

* To create a new environment (prod,uat,dev,etc), we need to create a new folder under the environments folder.

## Code creates these resources

- ACR
- AKS
- APIM
- App Insights
- Application Gateway
- Log Analytics Workspace
- Frontdoor
- Key Vault
- MS SQL
- Network Security Group
- Public IP
- Redis Cache
- Resource Group
- Role Assignment
- Route Table
- Storage Account
- User Managed Identity
- Vnet/Subnet

## Prerequisites
- Resource group to be created

## Components
- ACR module - This module is used to deploy ACR 

## Variables used in the module

Variable | Description | Type
--- | --- | ---
`name` | Name of the container registry | `string`
`resource_group_name` | Name of the resource group for deploying the resource | `string`
`location` | The region in which this module should be deployed | `string`
`tags` | A map of tags to assign to the resource | `map(string)`
`sku` | The SKU name of the container registry | `string`
`admin_enabled` | Mentions the admin is enabled or not for the resource | `bool`
`public_network_access_enabled` | Mentions the public network access is enabled  or not for the resource | `bool`
`zone_redundancy_enabled` | Mentions the zone redundancy is enabled or not for the resource | `bool`
`quarantine_policy_enabled` | Mentions the quarantine policy is enabled or not for the resource | `bool`
`trust_policy` | Mentions the trust policy is enabled or not for the resource | `bool`
`identity_ids` | The user managed identity that is used for the resource | `list(string)`
`key_vault_key_id` | The key vault key id used for thr resource | `string`
`identity_client_id` | The user managed identity client id  used for the resource | `string`
`subnet_id` | The subnet id of the private endpoint | `string`
`private_dns_zone_ids` | The private dns zone id of the ACR | `list(string)` 

## Components
- AKS module - This module is used to deploy AKS

## Variables used in the module

Variable | Description | Type
--- | --- | ---
`name` | Name of the kubernetes cluster | `string`
`location` | The region in which this module should be deployed | `string`
`resource_group_name` | Name of the resource group for deploying the resource | `string`
`kubernetes_version` | The version of the kubernetes used for deploying the resource | `string`
`sku_tier` | The SKU name of the container registry | `string`
`private_cluster_enabled` | Mentions the AKS cluster is private or not | `bool`
`private_dns_zone_id` | The private dns zone id of the AKS | `string`
`dns_prefix_private_cluster` | Name of the cluster | `string`
`tags` | A map of tags to assign to the resource | `map(string)`
`os_disk_size_gb` | The OS size of the cluster | `number`
`oidc_issuer_enabled` | The openID connect issuer for AKS | `bool`
`acrid` | The subscription id of the ACR | `string`
`workload_identity_enabled` | The entra workload identity on the AKS | `bool`
`local_account_disabled` | Mentions the local accounts on existing the AKS cluster | `bool`
`azure_policy_enabled` | Mentions the azure policy is implied or not for the resource | `bool`
`log_analytics_workspace_id` | The ID of the log analytics workspace | `string`
`msi_auth_for_monitoring_enabled` | The azure monitor container insights | `bool`
`default_node_pool` | The system node pool details | `map(object)`
`key_vault_secrets_provider` | The key vault secrets details | `map(object)`
`identity` | The user managed identity details | `object(string)`
`azure_active_directory_role_based_access_control` | The azure active directory RBAC details | `map(object)`
`network_profile` | The network details of the AKS cluster | `map(object)`
`kubernetes_cluster_node_pool` | The user node pool details | `list(object)`

## Components
- APIM module - This module is used to deploy API Management

## Variables used in the module

Variable | Description | Type
--- | --- | ---
`name` | The name of the APIM | `string`
`location` | The location where the APIM is deployed | `string`
`resource_group_name` | The name of the resources group for deploying the resource | `string` 
`publisher_name` | The name used for deploying the resource | `string`
`publisher_email` | The email used for deploying the resource | `string`
`sku_name` | The SKU name of the resource | `string`
`virtual_network_type` | The type of virtual network | `string`
`virtual_network_configuration` | The type of configuration required for deploying the resource | `map(object)`
`identity` | The user managed identity details | `object(string)` 
`tags` | A map of tags to assign to the resource | `map(string)`

## Components
- App gateway module - This module is used to deploy App gateway

## Variables used in the module

Variable | Description | Type
--- | --- | ---
`name` | Name of the App gateway | `string` 
`location` | The location where the App gateway is deployed | `string`
`resource_group_name` | The name of the resources group for deploying the resource | `string`
`tags` | A map of tags to assign to the resource | `map(string)`
`enable_http2` |
`force_firewall_policy_association` |
`identity` |
`sku` |
`gateway_ip_configuration` |
`frontend_ip_configuration` |
`frontend_port` |
