Write-Output "SQL Server: Installing SQL Server 2017..."

# Copy ISO from C:\vagrant where it can not be mounted from, apparently
Write-Output "SQL Server: Searching for SQL Server 2017 ISO in C:\vagrant"
$isoSrc = Get-ChildItem C:\vagrant\SQLServer2017*iso | Select-Object -First 1
Write-Output "SQL Server: Creating directory C:\iso"
$iso = (Join-Path C:\iso $isoSrc.Name)
if (Test-Path -Path $iso) {
    Write-Output "SQL Server: Dismounting ISO: $iso)"
    Dismount-DiskImage -ImagePath $iso
} else {
    Write-Output "SQL Server: Copying file $($isoSrc.FullName) to $($iso)"
    New-Item -ItemType Directory -Force -Path C:\iso | Out-Null
    Copy-Item ($isoSrc.FullName) $iso
}

# Mount ISO
Write-Output "SQL Server: Mounting ISO: $iso)"
$drivesBefore = (Get-Volume).DriveLetter
Mount-DiskImage -ImagePath $iso
$drivesAfter = (Get-Volume).DriveLetter
$isoMountDrive = (Compare-Object  -PassThru $drivesBefore $drivesAfter) + ':'
Write-Output "SQL Server: ISO mounted as $($isoMountDrive)"

# Install SQL Server
Write-Output "SQL Server: Running SQL Server installer"
$setupDir = (Join-Path $isoMountDrive '\')
Set-Location $setupDir
## In case of problems, add /INDICATEPROGRESS to see detailed setup log in vagrant host console
.\setup.exe /QUIET /IACCEPTSQLSERVERLICENSETERMS /ACTION=install /FEATURES=SQL /INSTANCENAME=MSSQLSERVER /TCPENABLED=1 /SECURITYMODE=SQL /SQLSVCACCOUNT="NT Authority\System" /SAPWD="Password123" /SQLSYSADMINACCOUNTS=vagrant
Write-Output "SQL Server: Running SQL Server installer - done"
Set-Location ~

# Dismount ISO
Write-Output "SQL Server: Dismounting ISO: $iso)"
Dismount-DiskImage -ImagePath $iso

# Finalise
Write-Output "SQL Server: Disabling Windows Firewall"
netsh advfirewall set allprofiles state off
Write-Output "SQL Server: Guest IP address"
netsh int ip show addresses
Write-Output "DONE"