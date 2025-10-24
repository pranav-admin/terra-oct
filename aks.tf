resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = local.vm_names[terraform.workspace]
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  size                = local.vm_size[terraform.workspace]
  admin_username      = "pranav"
  disable_password_authentication = false
  admin_password = "Pranav@123"
  network_interface_ids = [azurerm_network_interface.nic1.id]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  depends_on = [ azurerm_resource_group.rg1 ]
}