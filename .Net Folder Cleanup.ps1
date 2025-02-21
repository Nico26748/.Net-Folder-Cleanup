# Check for directory
if (Test-Path "C:\VPRD\MECM-Deployments") {

} else {
    New-Item -Path "C:\VPRD\MECM-Deployments" -ItemType Directory
}
Start-Transcript -Path "C:\VPRD\MECM-Deployments\.NET-Folder-Cleanup.log" -append
# Directories to check
$directories = @(
    "C:\Program Files\dotnet\shared\Microsoft.AspNetCore.App",
    "C:\Program Files\dotnet\shared\Microsoft.NETCore.App",
    "C:\Program Files\dotnet\shared\Microsoft.WindowsDesktop.App",
    "C:\Program Files\dotnet\sdk",
    "C:\Program Files (x86)\dotnet\shared\Microsoft.AspNetCore.App",
    "C:\Program Files (x86)\dotnet\shared\Microsoft.NETCore.App",
    "C:\Program Files (x86)\dotnet\shared\Microsoft.WindowsDesktop.App",
    "C:\Program Files (x86)\dotnet\sdk"
)

# Iterate over each directory to check and delete found old versions
foreach ($directory in $directories) {
	if (Test-Path $directory) {
		Get-ChildItem -Path $directory -Directory | ForEach-Object {
			$folderVersion = $_.Name
			if ($folderVersion -lt 8) {
				Write-Output "Removing $directory\$folderVersion..."
				Remove-Item -Path $_.FullName -Recurse -Force
				Write-Output "Removal complete."
			} else {
            # Revision that does not match found
				Write-Output "Skipping $directory\$folderVersion..."
            }
        }
	} else {
	Write-Output "Directory $directory does not exist."
	}
}
Stop-Transcript