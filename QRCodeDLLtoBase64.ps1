$Content = Get-Content -Path QRCoder.dll -AsByteStream
$Base64 = [System.Convert]::ToBase64String($Content)
$Base64 | Out-File encodedQRCoder.txt
