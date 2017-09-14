Write-Output "SQL Server: Installing base packages..."

# Install SQL Server requirements
Write-Output "SQL Server: Installing KB2919355"
Write-Output "SQL Server: Downloading ~700 MB, so sit tight..."
choco install -y kb2919355
Write-Output "SQL Server: Installing KB2919355 - done"
