cd ~\downloads

$API_URL = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"

$DOWNLOAD_URL = $(Invoke-RestMethod $API_URL).assets.browser_download_url |
    Where-Object {$_.EndsWith(".msixbundle")}

Invoke-WebRequest -URI $DOWNLOAD_URL -OutFile winget.msixbundle -UseBasicParsing

Add-AppxPackage winget.msixbundle

Remove-Item winget.msixbundle