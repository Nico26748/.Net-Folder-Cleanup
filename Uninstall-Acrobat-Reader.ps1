# Function to write output to a log file
function Write-Log
{
    Param ([string]$LogString)
    $LogFile = "C:\Windows\Logs\RemoveAcrobatReader-$(get-date -f yyyy-MM-dd).log"
    $DateTime = "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
    $LogMessage = "$Datetime $LogString"
    Add-content $LogFile -value $LogMessage
}

# Get installed programs for both 32-bit and 64-bit architectures
$paths = @('HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\','HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\')

$installedPrograms = foreach ($registryPath in $paths) {
    try {
        Get-ChildItem -LiteralPath $registryPath | Get-ItemProperty | Where-Object { $_.PSChildName -ne $null }
    } catch {
        Write-Log ("Failed to access registry path: $registryPath. Error: $_")
        return @()
    }
}

# Filter programs with Adobe Acrobat Reader in their display name, excluding Standard and Professional
$adobeReaderEntries = $installedPrograms | Where-Object {
    $_.DisplayName -like '*Adobe Acrobat*' -and
    $_.DisplayName -notlike '*Standard*' -and
    $_.DisplayName -notlike '*Professional*'
}

# Try to uninstall Adobe Acrobat Reader for each matching entry
foreach ($entry in $adobeReaderEntries) {
    $productCode = $entry.PSChildName

    try {
        # Use the MSIExec command to uninstall the product
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $productCode /qn" -Wait -PassThru

        Write-Log ("Adobe Acrobat Reader has been successfully uninstalled using product code: $productCode")
    } catch {
        Write-Log ("Failed to uninstall Adobe Acrobat Reader with product code $productCode. Error: $_")
    }
}