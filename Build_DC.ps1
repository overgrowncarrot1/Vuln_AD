# Set execution policy to unrestricted (if needed)
Set-ExecutionPolicy Unrestricted -Force

# Define Domain Variables
$DomainName = "maraudersec.local"
$NetBIOSName = "MARAUDERSEC"
$SafeModeAdminPassword = ConvertTo-SecureString "1qaz2wsx!QAZ@WSX" -AsPlainText -Force
$DNSServer = "127.0.0.1"  # This will be the local DC
$LogPath = "C:\Windows\NTDS"
$SysvolPath = "C:\Windows\SYSVOL"

# Set a Static IP Address (Ensure the correct InterfaceIndex)
$InterfaceIndex = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $InterfaceIndex -ServerAddresses ($DNSServer, "8.8.8.8")

# Install Active Directory Domain Services
Write-Host "Installing Active Directory Domain Services..."
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Import ADDSDeployment Module
Import-Module ADDSDeployment

# Promote to a Domain Controller
Write-Host "Promoting Server to Domain Controller..."
Install-ADDSForest `
    -DomainName $DomainName `
    -DomainNetbiosName $NetBIOSName `
    -ForestMode "WinThreshold" `
    -DomainMode "WinThreshold" `
    -InstallDns:$true `
    -NoRebootOnCompletion:$false `
    -LogPath $LogPath `
    -SysvolPath $SysvolPath `
    -SafeModeAdministratorPassword $SafeModeAdminPassword `
    -CreateDnsDelegation:$false `
    -Force:$true

Write-Host "Domain Controller setup complete! Rebooting now..."
Restart-Computer -Force
