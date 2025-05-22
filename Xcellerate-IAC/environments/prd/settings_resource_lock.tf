locals {
  configure_resource_lock = {

    settings = {
      resource-lock = {
        name       = "resource-lock-prod"
        resourceScope   = module.public_ip["pip-agw-${var.app_name}-${var.environment}-${var.location}-001"].id
        lock_level = "CanNotDelete"
      }
    }
  }

}