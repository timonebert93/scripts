param (
    [string]$DomainName,
    [string]$DomainNetbiosName,
    [string]$ForestMode,
    [string]$SafeModeAdminPassword
)

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

Import-Module ADDSDeployment

$securePassword = ConvertTo-SecureString $SafeModeAdminPassword -AsPlainText -Force

Install-ADDSForest `
    -DomainName $DomainName `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode $ForestMode `
    -DomainNetbiosName $DomainNetbiosName `
    -ForestMode $ForestMode `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true `
    -SafeModeAdministratorPassword $securePassword `
    -NoRebootOnCompletion:$true
