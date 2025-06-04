data "azurerm_resource_group" "rg" {
  name = var.existing_resource_group_name
  
  }

data "azurerm_virtual_network" "vnet" {
  name      = var.existing_virtual_network_name
  resource_group_name = "data.azurerm_resource_group.rg.name"
}

data "azurerm_subnet" "subnet" {
  name    = var.existing_subnet_name
  virtual_network_name    = "data.azurerm_virtual_network.vnet.name"
  resource_group_name = "data.azurerm_resource_group.rg.name"
}


data "azurerm_network_security_group" "existing_nsg" {
  name                = var.existing_nsg
  resource_group_name = "data.azurerm_resource_group.rg.name"
}

#------AVD Host Pool -----#

resource "azurerm_virtual_desktop_host_pool" "avd-host-pool" {
  name                      = var.host_pool_name
  location                  = data.azurerm_resource_group.rg.location
  resource_group_name       = data.azurerm_resource_group.rg.name
  type                      = var.host_pool_type
  load_balancer_type        = var.load_balancer_type
  maximum_sessions_allowed  = var.max_session_hosts
  validate_environment      = true
  description               = "AVD Host pool with no session host config"
}

#-----AVD workspace-------#

resource "azurerm_virtual_desktop_workspace" "avd_workspace" {
  name                = var.workspace_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

#-------AVD Application Group (Desktop)------#

resource "azurerm_virtual_desktop_application_group" "app_group" {
  name                = var.application_group_name
  resource_group_name = data.azurerm_resource_group.rg.name
  type                = "Desktop" 
  host_pool_id        = azurerm_virtual_desktop_host_pool.avd-host-pool.id
  description         = "AVD Desktop Application Group"
}

#---------AVD Workspace application group association--#

resource "azurerm_virtual_desktop_workspace_application_group_association" "workspace_grp_assc" {
  workapce_id           = azurerm_virtual_desktop_workspace.avd_workspace.id
  application_group_id  = azurerm_virtual_desktop_application_group.app_group.id
}

#-----NIC for session host--#

resource "azurerm_network_interface" "nic" {
  name                = "${var.session_host_vm_name}-nic"
  resource_group_name = data.azurerm_resource_group.rg.name


  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
#----------Associated the existing NSG with the NIC---#

resource "azurerm_network_interface_security_group_association" "example_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = data.azurerm_network_security_group.existing_nsg.id
}

#-----Session Hosts----#

resource "azurerm_windows_virtual_machine" "session_host_vm" {
  name                = var.session_host_vm_name
  resource_group_name = data.azurerm_resource_group.rg.name
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = "OptumPassword@098"
  security_type       ="TrustedLaunch"
  secure_boot_enabled = true
  vtpm_enabled        = true
  enable_intergrity_monitoring = true
  network_interface_ids = [azurerm_network_interface.nic.id]
  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-22h2-avd"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  boot_diagnostics {
    storage_account_uri = null
  }
}
#---------Domain join (Entra Intune) ---#

resource "azurerm_virtual_machine_extension" "aad_join" {
  name      = "AADLogin"
  virtual_machine_id = azurerm_windows_virtual_machine.session_host_vm.id
  publisher          = "Microsoft.Azure.ActiveDirectory"
  type               = "AADLoginForWindows"
  type_handler_version = "1.0"
}



















