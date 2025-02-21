Param (
    [Parameter(Mandatory=$false)] [string] $Runtime = "dotnet",
    [Parameter(Mandatory=$false)] [string] $VersionNumber = "3.1.32",
    [Parameter(Mandatory=$false)] [string] $Option = "uninstall"
)

$DownloadSelection = "$Runtime-$VersionNumber"

$DotNetList =
@([pscustomobject]@{name="DotNet-3.1.32";link="https://download.visualstudio.microsoft.com/download/pr/476eba79-f17f-49c8-a213-0f24a22cd026/37c02de81ff5b76ac57a5427462395f1/dotnet-runtime-3.1.32-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-3.1.32";link="https://download.visualstudio.microsoft.com/download/pr/98910750-2644-472c-ab2b-17f315ccb953/c2a4c223ee11e2eec7d13744e7a45547/aspnetcore-runtime-3.1.32-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-3.1.32";link="https://download.visualstudio.microsoft.com/download/pr/b92958c6-ae36-4efa-aafe-569fced953a5/1654639ef3b20eb576174c1cc200f33a/windowsdesktop-runtime-3.1.32-win-x64.exe"},

[pscustomobject]@{name="DotNet-5.0.17";link="https://download.visualstudio.microsoft.com/download/pr/a0832b5a-6900-442b-af79-6ffddddd6ba4/e2df0b25dd851ee0b38a86947dd0e42e/dotnet-runtime-5.0.17-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-5.0.17";link="https://download.visualstudio.microsoft.com/download/pr/3789ec90-2717-424f-8b9c-3adbbcea6c16/2085cc5ff077b8789ff938015392e406/aspnetcore-runtime-5.0.17-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-5.0.17";link="https://download.visualstudio.microsoft.com/download/pr/3aa4e942-42cd-4bf5-afe7-fc23bd9c69c5/64da54c8864e473c19a7d3de15790418/windowsdesktop-runtime-5.0.17-win-x64.exe"},

[pscustomobject]@{name="DotNet-6.0.32";link="https://download.visualstudio.microsoft.com/download/pr/4515aaaa-c7d5-40bf-b7fd-f476d6ea3b1a/c545ea92dbd537753aefb937478fd532/dotnet-runtime-6.0.32-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-6.0.32";link="https://download.visualstudio.microsoft.com/download/pr/cd77851b-80d8-4ef6-87ee-afbaf715cea5/a2e9029cd1d4f0e35641e42852ac911e/aspnetcore-runtime-6.0.32-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-6.0.32";link="https://download.visualstudio.microsoft.com/download/pr/222a065f-5671-4aed-aba9-46a94f2705e2/2bbcbd8e1c304ed1f7cef2be5afdaf43/windowsdesktop-runtime-6.0.32-win-x64.exe"},

[pscustomobject]@{name="DotNet-6.0.36";link="https://download.visualstudio.microsoft.com/download/pr/1a5fc50a-9222-4f33-8f73-3c78485a55c7/1cb55899b68fcb9d98d206ba56f28b66/dotnet-runtime-6.0.36-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-6.0.36";link="https://download.visualstudio.microsoft.com/download/pr/0f0ea01c-ef7c-4493-8960-d1e9269b718b/3f95c5bd383be65c2c3384e9fa984078/aspnetcore-runtime-6.0.36-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-6.0.36";link="https://download.visualstudio.microsoft.com/download/pr/f6b6c5dc-e02d-4738-9559-296e938dabcb/b66d365729359df8e8ea131197715076/windowsdesktop-runtime-6.0.36-win-x64.exe"},
[pscustomobject]@{name="HostingBundle-6.0.36";link="https://download.visualstudio.microsoft.com/download/pr/9b8253ef-554d-4636-b708-e154c0199ce5/f3673dd1f2dc80e5b0505cbd2d4bd5d2/dotnet-hosting-6.0.36-win.exe"},

[pscustomobject]@{name="DotNet-7.0.7";link="https://download.visualstudio.microsoft.com/download/pr/ce1d21d9-d3fb-451f-84b1-95f365bcbc2c/23748d17eed2e1c63fdbb6b29d147c2d/dotnet-runtime-7.0.7-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-7.0.7";link="https://download.visualstudio.microsoft.com/download/pr/754ad45c-5713-4bf7-8182-e82291e12d2f/4fbc681a6d28c7895b46940ebe573ae3/aspnetcore-runtime-7.0.7-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-7.0.7";link="https://download.visualstudio.microsoft.com/download/pr/342ba160-3776-4ffa-91dd-e3cd9dc0f817/ba649d6b80b27ca164d80bd488cdb51f/windowsdesktop-runtime-7.0.7-win-x64.exe"},

[pscustomobject]@{name="DotNet-7.0.13";link="https://download.visualstudio.microsoft.com/download/pr/7f25ba8c-e2f3-4432-83c2-8ab41e361a3e/5201929d4c9b5752a47a9cf4d2b494e0/dotnet-runtime-7.0.13-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-7.0.13";link="https://download.visualstudio.microsoft.com/download/pr/2047544d-b948-480e-a4ce-2d5276d906dc/010c6e5c6b822dc2121c1d23f0820cf6/aspnetcore-runtime-7.0.13-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-7.0.13";link="https://download.visualstudio.microsoft.com/download/pr/515cc796-e9f2-4b5c-be7f-b42f115a65a7/b0b146fcbf1d1c135807ff24b3d88093/windowsdesktop-runtime-7.0.13-win-x64.exe"},

[pscustomobject]@{name="DotNet-7.0.20";link="https://download.visualstudio.microsoft.com/download/pr/be7eaed0-4e32-472b-b53e-b08ac3433a22/fc99a5977c57cbfb93b4afb401953818/dotnet-runtime-7.0.20-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-7.0.20";link="https://download.visualstudio.microsoft.com/download/pr/10651a65-8afc-46e3-9287-fecb0e68504e/4c2bf0cdb44612f29d9b3f901098e13e/aspnetcore-runtime-7.0.20-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-7.0.20";link="https://download.visualstudio.microsoft.com/download/pr/08bbfe8f-812d-479f-803b-23ea0bffce47/c320e4b037f3e92ab7ea92c3d7ea3ca1/windowsdesktop-runtime-7.0.20-win-x64.exe"},

[pscustomobject]@{name="DotNet-8.0.6";link="https://download.visualstudio.microsoft.com/download/pr/e4d4b66c-0581-41a1-b7ee-f23ccc79e4ec/1b56841378536d2795faaa214b2872e7/dotnet-runtime-8.0.6-win-x64.exe"},
[pscustomobject]@{name="ASPNetCore-8.0.6";link="https://download.visualstudio.microsoft.com/download/pr/38b32fc8-8070-4f14-bd52-65505fddc5ff/50e6cf3b7505eee02c3b3db8ea46ffe3/aspnetcore-runtime-8.0.6-win-x64.exe"},
[pscustomobject]@{name="DesktopRuntime-8.0.6";link="https://download.visualstudio.microsoft.com/download/pr/76e5dbb2-6ae3-4629-9a84-527f8feb709c/09002599b32d5d01dc3aa5dcdffcc984/windowsdesktop-runtime-8.0.6-win-x64.exe"})

$DotNetSelection = $DotNetList | Where-Object { $_.name -eq $DownloadSelection }
    foreach ($item in $DotNetSelection) {
        $DownloadLink = $item.link
}

function download_dotnet
{
    if (!(Test-Path -Path "C:\Temp"))
    {
        New-Item -ItemType Directory -Path "C:\Temp"
	    $Outfile = "C:\Temp\$Runtime-$VersionNumber.exe"
	    Invoke-WebRequest -uri $DownloadLink -OutFile $Outfile

	    start-sleep -s 15
    }
    else {
        $Outfile = "C:\Temp\$Runtime-$VersionNumber.exe"
	    Invoke-WebRequest -uri $DownloadLink -OutFile $Outfile

	    start-sleep -s 15
    }
}

$DownloadPath = "C:\Temp\$Runtime-$VersionNumber.exe"

download_dotnet

Start-Process -NoNewWindow -FilePath $DownloadPath -ArgumentList "/$Option","/Quiet" -Wait

rm $DownloadPath