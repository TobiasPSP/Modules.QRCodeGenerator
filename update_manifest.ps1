$version = '2.0'
$name = "QRCodeGenerator"
$localPath = "C:\Github\Modules.$name"

$Path = "$localPath\$name\$version\$name.psd1"


New-ModuleManifest -Path $Path -CompanyName 'powershell.one' -Author 'Dr. Tobias Weltner' -Description 'creates QR codes offline' -FunctionsToExport 'New-PSOneQRCodeGeolocation', 'New-PSOneQRCodeTwitter', 'New-PSOneQRCodeWifi', 'New-PSOneQRCodeVCard' -AliasesToExport 'New-QRCodeGeolocation', 'New-QRCodeTwitter', 'New-QRCodeVCard', 'New-QRCodeWifiAccess' -CompatiblePSEditions 'Core','Desktop' -PowerShellVersion 5.1 -Copyright '2020 Dr. Tobias Weltner (MIT-License)' -ModuleVersion $version -ReleaseNotes 'added prefix "PSOne" to function nouns, added aliases for old function names, loading binary now via string' -ProjectUri 'https://github.com/TobiasPSP/Modules.QRCodeGenerator' -LicenseUri 'https://en.wikipedia.org/wiki/MIT_License' -Tags QRCode,powershell.one -RootModule loader.psm1

# remove comments from manifest
(Get-Content -Path $Path -Encoding UTF8 -ReadCount 0) |
  Where-Object { $_ -notmatch '^\s{0,}#' } |
  Where-Object { $_.Trim().Length -gt 0 } |
  ForEach-Object {
    $_ -replace '#.*?$'
  } |
  Set-Content -Path $Path -Encoding UTF8