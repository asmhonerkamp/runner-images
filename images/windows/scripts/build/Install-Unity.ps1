[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]
    $UnityVersion,
    [Parameter(Mandatory = $true)]
    [String[]]
    $Components
)

#Requires -RunAsAdministrator

try {
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted
    Install-Module -Name UnitySetup -Force

    $installer = Find-UnitySetupInstaller -Version $UnityVersion -Components $Components
    
    $installer | Install-UnitySetupInstance 
}
catch
{
    Write-Host "Error installing Unity version: ($UnityVersion) with components: ($Components)"
    Write-Host $_.Exception.Message
}
