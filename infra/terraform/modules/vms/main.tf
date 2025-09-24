################ GITHUB SELF-HOSTED RUNNER VM ################
resource "azurerm_network_interface" "runner_nic" {
  name                = "${var.project_name}-runner-nic"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "runner-ipcfg"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "runner_vm" {
  name                = "${var.project_name}-runner-vm"
  location            = var.region
  resource_group_name = var.resource_group_name
  size                = var.runner_vm_size

  network_interface_ids = [
    azurerm_network_interface.runner_nic.id
  ]

  admin_username      = var.runner_vm_admin_username

  admin_ssh_key {
    username   = var.runner_vm_admin_username
    public_key = var.runner_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }

  custom_data = base64encode(templatefile("${path.module}/init_gh_runner.sh.tpl", {
    runner_token = var.runner_registration_token
    github_url   = var.runner_github_url
    runner_name  = "${var.project_name}-runner"
  }))
}