############################################################################################################
#                                         Initial Setup                                                    #
#                                                                                                          #
############################################################################################################
param (
    [string[]]$customwhitelist
)

 

##Elevate if needed

 

If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Write-Host "You didn't run this script as an Administrator. This script will self elevate to run as an Administrator and continue."
    Start-Sleep 1
    Write-Host "                                               3"
    Start-Sleep 1
    Write-Host "                                               2"
    Start-Sleep 1
    Write-Host "                                               1"
    Start-Sleep 1
    Start-Process powershell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`" -WhitelistApps {1}" -f $PSCommandPath, ($WhitelistApps -join ',')) -Verb RunAs
    Exit
}

 

#no errors throughout
$ErrorActionPreference = 'silentlycontinue'

 

 

#Create Folder
$DebloatFolder = "C:\ProgramData\Debloat"
If (Test-Path $DebloatFolder) {
    Write-Output "$DebloatFolder exists. Skipping."
}
Else {
    Write-Output "The folder '$DebloatFolder' doesn't exist. This folder will be used for storing logs created after the script runs. Creating now."
    Start-Sleep 1
    New-Item -Path "$DebloatFolder" -ItemType Directory
    Write-Output "The folder $DebloatFolder was successfully created."
}

 

Start-Transcript -Path "C:\ProgramData\Debloat\Debloat.log"

 

$locale = Get-WinSystemLocale | Select-Object -expandproperty Name

 

##Switch on locale to set variables
## Switch on locale to set variables
switch ($locale) {
    "en-US" {
        $everyone = "Everyone"
        $builtin = "Builtin"
    }    
    "en-GB" {
        $everyone = "Everyone"
        $builtin = "Builtin"
    }
    default {
        $everyone = "Everyone"
        $builtin = "Builtin"
    }
}

 

$manufacturer = "Dell"

 

if ($manufacturer -like "*Dell*") {
    Write-Host "Dell detected"
    #Remove Dell bloat

 

##Dell

 

$UninstallPrograms = @(
    "Dell SupportAssist OS Recovery"
    "Dell SupportAssist"
    "DellInc.DellSupportAssistforPCs"
    "Dell SupportAssist Remediation"
    "SupportAssist Recovery Assistant"
    "Dell SupportAssist OS Recovery Plugin for Dell Update"
    "Dell SupportAssistAgent"
    "Dell Update - SupportAssist Update Plugin"
    "Dell SupportAssist Remediation"
    "Dell Update - SupportAssist Update Plugin"
)

 

 

$WhitelistedApps += @(
    "Dell Optimizer"
    "Dell Power Manager"
    "DellOptimizerUI"
    "Dell Optimizer Service"
    "Dell Optimizer Core"
    "DellInc.PartnerPromo"
    "DellInc.DellOptimizer"
    "DellInc.DellCommandUpdate"
    "DellInc.DellPowerManager"
    "DellInc.DellDigitalDelivery"
    "DellInc.PartnerPromo"
    "Dell Command | Update"
    "Dell Command | Update for Windows Universal"
    "Dell Command | Update for Windows 10"
    "Dell Command | Power Manager"
    "Dell Digital Delivery Service"
    "Dell Digital Delivery"
    "Dell Peripheral Manager"
    "Dell Power Manager Service"
    "Dell Core Services"
    "Dell Pair"
    "Dell Display Manager 2.0"
    "Dell Display Manager 2.1"
    "Dell Display Manager 2.2"
    "DellInc.PartnerPromo"
    "WavesAudio.MaxxAudioProforDell2019"
    "Dell - Extension*"
    "Dell, Inc. - Firmware*"
    "Dell Optimizer Core"
    "Dell SupportAssist OS Recovery Plugin for Dell Update"
    "Dell Pair"
    "Dell Display Manager 2.0"
    "Dell Display Manager 2.1"
    "Dell Display Manager 2.2"
    "Dell Peripheral Manager"
)

 

 

    $UninstallPrograms = $UninstallPrograms | Where-Object{$WhitelistedApps -notcontains $_}

 

 

foreach ($app in $UninstallPrograms) {

    if (Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app -ErrorAction SilentlyContinue) {
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online
        Write-Host "Removed provisioned package for $app."
    } else {
        Write-Host "Provisioned package for $app not found."
    }

 

    if (Get-AppxPackage -Name $app -ErrorAction SilentlyContinue) {
        Get-AppxPackage -allusers -Name $app | Remove-AppxPackage -AllUsers
        Write-Host "Removed $app."
    } else {
        Write-Host "$app not found."
    }

 

    UninstallAppFull -appName $app
}

 

##Belt and braces, remove via CIM too
foreach ($program in $UninstallPrograms) {
    write-host "Removing $program"
    Get-CimInstance -Classname Win32_Product | Where-Object Name -Match $program | Invoke-CimMethod -MethodName UnInstall
    }

 

##Manual Removals

 

##Dell Dell SupportAssist Remediation
$dellSA = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -match "Dell SupportAssist Remediation" } | Select-Object -Property QuietUninstallString

ForEach ($sa in $dellSA) {
    If ($sa.QuietUninstallString) {
        try {
            cmd.exe /c $sa.QuietUninstallString
            }
            catch {
                Write-Warning "Failed to uninstall Dell Support Assist Remediation"
            }    }
}

 

##Dell Dell SupportAssist OS Recovery Plugin for Dell Update
$dellSA = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -match "Dell SupportAssist OS Recovery Plugin for Dell Update" } | Select-Object -Property QuietUninstallString

ForEach ($sa in $dellSA) {
    If ($sa.QuietUninstallString) {
        try {
            cmd.exe /c $sa.QuietUninstallString
            }
            catch {
                Write-Warning "Failed to uninstall Dell Support Assist Remediation"
            }    }
}

 

}
write-host "Completed"

 

Stop-Transcript