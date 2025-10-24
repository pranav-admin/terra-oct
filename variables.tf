# variable "rg-name" {
#     type =string
#     default = "pranav-aks-rg"
# }
# variable "rg-location" {
#     type = list(string)
#     default = ["eastus", "centralus", "centralindia", "westus"]
# }
# variable "pip-name" {
#     type = string
#     default = "lb-pip"
# }

# variable "ssh-port" {
#     default = 22
#     type = number
# }

# variable "http-port" {
#     default = 80
#     type = number
# }

# variable "https-port" {
#     default = 443
#     type = number
# }

# variable "rdp-port" {
#     default = 3389
#     type = number
# }


# variable "size" {
#   type = map(string)
#   default = {
#     "dev" = "Standard_F2"
#     "test" = "Standard_B1s"
#     "prod" = "Standard_D2s_v3"
#   }
# }

# variable "is_production" {
#   type = bool
#   default = false
# }


# variable "vms" {
#   type = map(object({
#     name = string
#     size = string
#   }))
#   default = {
#     "vm1" = {
#       name = "linux-machine-web"
#       size = "Standard_B1s"
#     }
#     "vm2" = {
#         name = "linux-machine-db"
#         size = "Standard_F2"
#     }
#     "vm3" = {
#         name = "linux-machine-backend"
#         size = "Standard_D2s_v3"
#     }
#   }
# }


# variable "vm_names" {
#   default = ["vm1", "vm2", "vm3"]
# }

# variable "subnet_map" {
#   type = map(string)
#   default = {
#     subnet1 = "10.0.0.0/24"
#     subnet2 = "10.0.1.0/24"
#     subnet3 = "10.0.2.0/24"
#   }

# }


variable "security_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string

  }))

  default = [{
    name                       = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    },
    {
      name                       = "allow-http"
      priority                   = 101
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "80"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-https"
      priority                   = 102
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    },
    {
      name                       = "allow-rdp"
      priority                   = 103
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3389"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
  }]
}



# variable "destination" {
#   default = [
#     "/home/pranav/terra.log",
#     "/tmp/terra.log",
#     "/mnt/terra.log"
#   ]
# }







