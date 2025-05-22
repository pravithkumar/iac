# output "resource_groups" {
#   value = {
#     for rg in azurerm_resource_group.rg :
#     rg.name => {
#       name = rg.name
#       id   = rg.id
#     }
#   }
# }
