# Vagrant SQL Server 2017 RC2 on Microsoft Hyper-V Server 2012 R2

[Vagrant](https://www.vagrantup.com/) configuration to provide users with
virtual environment for hassle-free fun with [SQL Server 2017](https://www.microsoft.com/en-us/sql-server/sql-server-2017).

Looking for SQL Server 2017 on Linux VM? Check https://github.com/mloskot/vagrant-sqlserver

## Features

* [Hyper-V Server 2012 R2](https://technet.microsoft.com/en-us/library/hh833684(v=ws.11).aspx)
* [SQL Server 2017](http://www.microsoft.com/en-us/sql-server/sql-server-2017)
* Pre-configured with
  * Vagrant default user: `vagrant` with password `vagrant`
  
  * Port forwarding from host `3433` to guest `1433` (default).
  * Default instance name `MSSQLSERVER`.
  * Database user `sa` with password `Password123`.
  * Database `master`.
  * Guest local account `vagrant` is member of sysadmin role; authenticated from inside the VM, without password.
  
## Requirements

* `vagrant plugin install vagrant-reload`
* Downloaded `SQLServer2017RC2-x64-ENU.iso` (1.5GB, see below)

## Installation

### Download SQL Server 2017 ISO

1. [Download](https://www.microsoft.com/en-us/sql-server/sql-server-2017) SQL Server 2017 installer for Windows.
2. Run the installer and choose to download SQL Server 2017 full ISO.
3. Copy the ISO next to this Vagrantfile.

### Run

1. `git clone` this repository or [download ZIP](https://github.com/mloskot/vagrant-sqlserver/archive/master.zip).
2. `cd vagrant-sqlserver-windows`
3. Copy the downloaded `SQLServer2017RC2-x64-ENU.iso` into the cloned repository (next to `Vagrantfile`).
4. Follow the [Usage](#usage) section.

## Usage

### Vagrant VM

* `vagrant up` to create and boot the guest virtual machine.
First time run, this may take quite a while as the base box image is downloaded
and provisioned, packages installed.

* `vagrant ssh` to get direct access to the guest shell via SSH.
You'll be connected as the vagrant user.
You can get root access with `sudo` command.

* `vagrant halt` to shutdown the guest machine.

* `vagrant destroy` to wipe out the guest machine completely.
You can re-create it and start over with `vagrant up`.

### SQL Server

Using SSMS as `SA` or using [sqlcmd](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility) client:

* Connect to SQL Server instance from inside the guest VM

```
vagrant ssh
sqlcmd -Q "SELECT @@version;"     # as vagrant user, no password
sqlcmd -S localhost,3433 -U sa -P Password123 -Q "SELECT name FROM sys.databases;"
```

* Connect to SQL Server instance from host

```
sqlcmd -S localhost,2433 -U SA -P Password123 -Q "SELECT name FROM sys.databases;"
```

## Credits

* Marc Abramowitz for his [Microsoft Hyper-V Server 2012 R2](https://github.com/msabramo/vagrant_hyperv_server_free) Vagrant image.
