resource "azurerm_app_service_environment_v3" "ase" {
  name                          = var.ase_name
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id
  internal_load_balancing_mode  = var.internal_load_balancing_mode
  timeouts {
        create = "120m"
        delete = "120m"
      }
  cluster_setting {
    name  = "DisableTls1.0"
    value = var.disable_tls1_0
  }
  cluster_setting {
    name  = "InternalEncryption"
    value = var.internal_encryption
  }
  cluster_setting {
    name  = "FrontEndSSLCipherSuiteOrder"
    value = var.frontend_ssl_cipher_suite_order
  }
 

cluster_setting {
  name = "FtpEnabled"
  value = false
}
cluster_setting {
  name = "AllowNewPrivateEndpointConnections"
  value = true
}
cluster_setting {
  name = "MaxWorkerCount"
  value = 10
}
cluster_setting {
  name = "DiagnosticLogsEnabled"
  value = true
}

  tags = var.tags
}