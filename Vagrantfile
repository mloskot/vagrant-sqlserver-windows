# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrant virtual environments for SQL Server 2017 on Windows

# TODO: UPDATE ISO FILENAME, IF NEW RELEASE IS OUT
if ! File.exists?('./SQLServer2017RC2-x64-ENU.iso')
  puts 'SQLServer2017RC2-x64-ENU.iso could not be found!'
  puts '1. Go to https://www.microsoft.com/en-us/sql-server/sql-server-2017'
  puts '2. Download SQL Server 2017 installer'
  puts '3. Run the installer and choose to download SQL Server 2017 ISO'
  puts '4. Copy the ISO next to this Vagrantfile'
  exit 1
end

Vagrant.configure(2) do |config|
  config.vm.box = "msabramo/HyperVServer2012"
  config.vm.box_check_update = true
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.network "private_network", type: "dhcp"
  config.vm.network :forwarded_port, host: 3433, guest: 1433
  config.vm.network "private_network", type: "dhcp"
  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 4
    vb.memory = "8192"
    vb.gui = true
    vb.customize ["modifyvm", :id, "--vram", 256]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--accelerate2dvideo", "on"]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  config.vm.provision "shell", path: "install-sqlserver-prerequisites.ps1", privileged: true
  config.vm.provision :reload
  config.vm.provision "shell", path: "install-sqlserver-from-iso.ps1", privileged: true
end
