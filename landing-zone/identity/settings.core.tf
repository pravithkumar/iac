locals {
  custom_landing_zones = {
    "${var.root_id}" = {
      display_name               = "Enterprise Scale"
      parent_management_group_id = data.azurerm_client_config.current.tenant_id
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_root"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-platform" = {
      display_name               = "Platform"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_platform"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-connectivity" = {
      display_name               = "Connectivity"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = var.connectivity_subscription_ids
      archetype_config = {
        archetype_id   = "es_connectivity"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-identity" = {
      display_name               = "Identity"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = var.identity_subscription_ids
      archetype_config = {
        archetype_id   = "es_identity"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-management" = {
      display_name               = "Management"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = var.management_subscription_ids
      archetype_config = {
        archetype_id   = "es_management"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-landingzone" = {
      display_name               = "Landing Zones"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   =  "es_landing_zones"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-corp-us-eus" = {
      display_name               = "Corp-us-eus"
      parent_management_group_id = "${var.root_id}-landingzone"
      subscription_ids           = var.corp-us-eus_subscription_ids
      archetype_config = {
        archetype_id   = "corp_landingzone"
        parameters     = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = [
              var.primary_location,
              var.secondary_location,
            ]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = [
              var.primary_location,
              var.secondary_location,
            ]
          }          
        }
        access_control = {}
      }
    }
    "${var.root_id}-corp-us-cus" = {
      display_name               = "Corp-us-cus"
      parent_management_group_id = "${var.root_id}-landingzone"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "corp_landingzone"
        parameters     = {
          Deny-Resource-Locations = {
            listOfAllowedLocations = [
              var.primary_location,
              var.secondary_location,
            ]
          }
          Deny-RSG-Locations = {
            listOfAllowedLocations = [
              var.primary_location,
              var.secondary_location,
            ]
          }          
        }
        access_control = {}
      }
    }
    "${var.root_id}-corp-uk-weu" = {
      display_name               = "Corp-uk-weu"
      parent_management_group_id = "${var.root_id}-landingzone"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-corp-uk-uks" = {
      display_name               = "Corp-uk-uks"
      parent_management_group_id = "${var.root_id}-landingzone"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }    
    "${var.root_id}-sandbox" = {
      display_name               = "Sandbox"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_sandbox"
        parameters     = {}
        access_control = {}
      }
    }
  }    
}