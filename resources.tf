locals {
  vm_size = {
    default = "Standard_F2"
    prod = "Standard_D2s_v3"
    dev = "Standard_B1s"
    stage = "Standard_B2s"
  }
}

locals {
  rg-names = {
    default = "pranav-default-rg"
    prod = "pranav-prod-rg"
    dev = "pranav-dev-rg"
    stage = "pranav-stage-rg"
  }
}

locals {
  location = {
    default = "eastus"
    prod = "centralus"
    dev = "centralindia"
    stage = "westus"
  }
}

locals {
  subscriptions = {
    default = "123456"
    prod = "112233"
    dev = "444123"
    stage = "789456"
  }
}


locals {
  vm_names = {
    default = "pranav-default-vm"
    prod = "pranav-prod-vm"
    dev = "pranav-dev-vm"
    stage = "pranav-stage-vm"
  }
}


resource "azurerm_resource_group" "rg1" {
  name = local.rg-names[terraform.workspace]
  location = local.location[terraform.workspace]
}

resource "azurerm_virtual_network" "vnet1" {
  name                = "pranav-network"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5", "8.8.8.8"]
  depends_on = [ azurerm_resource_group.rg1 ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "linux-sub"
  resource_group_name  = azurerm_resource_group.rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.5.0/24"]
  depends_on = [ azurerm_virtual_network.vnet1 ]

}

resource "azurerm_public_ip" "pip1" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg1.name
  location            = azurerm_resource_group.rg1.location
  allocation_method   = "Static"
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [ azurerm_resource_group.rg1 ]
}

resource "azurerm_network_interface" "nic1" {
  name                = "linux-nic"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip1.id
  }
  depends_on = [ azurerm_resource_group.rg1, azurerm_subnet.subnet1 ]
}
















# module "azure_vm" {
#   source = "C:/terra-oct/azure/custom-modules"
#   admin_username = "pranav"
#   address_prefixes = "10.0.6.0/24"
#   vm_size = "Standard_D2s_v3"
#   location = "centralus"
#   rg-name = "pranav-module-rg"
#   admin_password = "Pranav@123"
# }

# module "avm-res-network-virtualnetwork" {
#   source  = "Azure/avm-res-network-virtualnetwork/azurerm"
#   version = "0.15.0"
#   # insert the 2 required variables here
#   location = "eastus"
#   parent_id = "/subscriptions/2df30ff1-915d-4d35-974a-3d3155aaa413/resourceGroups/pranav-module-rg"
# }




























# data "azurerm_resource_group" "rg1" {
#   name = "pranav-rg"
# }



# output "VM_Public_IP" {
#   value = azurerm_public_ip.pip1.ip_address
# }



# locals {
#   env = "prod"
#   is_prod = local.env == "prod"
#   vm_size = local.is_prod ? "Standard_D2s_v3" : "Standard_F2"
#   vm_name = "${local.env}-vm"
#   rg_name = "${local.env}-rg"
#   location = "eastus"
# }


# resource "azurerm_resource_group" "rg1" {
#   name     = local.rg_name
#   location = local.location
# }



# resource "azurerm_network_security_group" "sg1" {
#   name                = "acceptanceTestSecurityGroup1"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name

#   security_rule {
#     name                       = "allow-ssh"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = var.ssh-port
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   security_rule {
#     name                       = "allow-http"
#     priority                   = 101
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = var.http-port
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   security_rule {
#     name                       = "allow-https"
#     priority                   = 102
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = var.https-port
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   security_rule {
#     name                       = "allow-rdp"
#     priority                   = 104
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = var.rdp-port
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
#   security_rule {
#     name                       = "allow-internet"
#     priority                   = 103
#     direction                  = "Outbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }






# resource "azurerm_public_ip" "lb-pip" {
#   name                = var.pip-name
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name
#   allocation_method   = "Static"
# }



# resource "azurerm_lb" "example" {
#   name                = "TestLoadBalancer"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name

#   frontend_ip_configuration {
#     name                 = "PublicIPAddress"
#     public_ip_address_id = azurerm_public_ip.lb-pip.id
#   }
# }

# resource "azurerm_lb_backend_address_pool" "pool1" {
#   loadbalancer_id = azurerm_lb.example.id
#   name            = "BackEndAddressPool"
# }


# resource "azurerm_network_interface_backend_address_pool_association" "nic-backend" {
#   network_interface_id    = azurerm_network_interface.nic1.id
#   ip_configuration_name   = "internal"  #use the name of NIC IP_Configuration
#   backend_address_pool_id = azurerm_lb_backend_address_pool.pool1.id
# }

# resource "azurerm_lb_rule" "lb-rule" {
#   loadbalancer_id                = azurerm_lb.example.id
#   name                           = "HTTPRule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = "PublicIPAddress"  #use the name Load Balancer's frontend ip configuration
#   backend_address_pool_ids = [azurerm_lb_backend_address_pool.pool1.id]
# }



# resource "azurerm_storage_account" "storage" {
#   name                     = "pranavaksbackup"
#   resource_group_name      = azurerm_resource_group.rg1.name
#   location                 = azurerm_resource_group.rg1.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"
# }

# resource "azurerm_storage_container" "container" {
#   name                  = "backup"
#   storage_account_id    = azurerm_storage_account.storage.id
#   container_access_type = "private"
# }

# resource "azurerm_storage_blob" "backup-file" {
#   name                   = "terra-backup"
#   storage_account_name   = azurerm_storage_account.storage.name
#   storage_container_name = azurerm_storage_container.container.name
#   type                   = "Block"
#   source                 = "sp.txt"
# }


# resource "azurerm_virtual_network" "vnet1" {
#   name                = "pranav-network"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name
#   address_space       = ["10.0.0.0/16"]
#   dns_servers         = ["10.0.0.4", "10.0.0.5", "8.8.8.8"]
#   depends_on = [ azurerm_resource_group.rg1 ]


#   subnet {
#     name             = "subnet1"
#     address_prefixes = ["10.0.1.0/24"]
#   }
# }


# resource "azurerm_subnet" "subnet1" {
#   name                 = "pranav-subnet"
#   resource_group_name  = azurerm_resource_group.rg1.name
#   virtual_network_name = azurerm_virtual_network.vnet1.name
#   address_prefixes     = ["10.0.2.0/24"]
#   depends_on = [ azurerm_resource_group.rg1, azurerm_virtual_network.vnet1 ]

# }




# resource "azurerm_network_interface" "nic1" {
#   name                = "pranav-nic1"
#   location            = azurerm_resource_group.rg1.location
#   resource_group_name = azurerm_resource_group.rg1.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet1.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.pip1.id
#   }
#   depends_on = [ azurerm_resource_group.rg1, azurerm_subnet.subnet1, azurerm_public_ip.pip1 ]
# }






# resource "azurerm_windows_virtual_machine" "win" {
#   name                = "win-machine"
#   resource_group_name = azurerm_resource_group.rg1.name
#   location            = azurerm_resource_group.rg1.location
#   size                = "Standard_D2s_v3"
#   admin_username      = "pranav"
#   admin_password      = "Pranav@123"
#   network_interface_ids = [
#     azurerm_network_interface.nic1.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "microsoftwindowsdesktop"
#     offer     = "windows-11"
#     sku       = "win11-23h2-ent"
#     version   = "latest"
#   }
# }