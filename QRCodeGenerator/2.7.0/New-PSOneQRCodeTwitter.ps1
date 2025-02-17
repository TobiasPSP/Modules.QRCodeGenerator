function New-PSOneQRCodeTwitter
{
    <#
            .SYNOPSIS
            Creates a QR code graphic containing a twitter profile

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - opens the twitter profile.

            .PARAMETER ProfileName
            The twitter profile name
            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCodeTwitter -ProfileName tobiaspsp -Width 200 -Show -OutPath "$home\Desktop\qr.png"
            Creates a QR code png graphics on your desktop, and opens it with the associated program

            .NOTES
            Compatible with all PowerShell versions including PowerShell 6/Core
            Uses binaries from https://github.com/codebude/QRCoder/wiki

            .LINK
            https://github.com/TobiasPSP/Modules.QRCodeGenerator
    #>

    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $ProfileName,
        
        [ValidateRange(10,2000)]
        [int]
        $Width = 100,

        [Switch]
        $Show,

        [string]
        $OutPath = "$env:temp\qrcode.png",

        [byte[]] 
        $DarkColorRgba = @(0,0,0),

        [byte[]]
        $LightColorRgba = @(255,255,255)
    )

    
    $payload = "http://www.twitter.com/$ProfileName"
 
    Write-Verbose "$ProfileName $Width $Show $OutPath $payload"

    New-PSOneQRCode -payload $payload -Show $Show -Width $Width -OutPath $OutPath -darkColorRgba $darkColorRgba -lightColorRgba $lightColorRgba

}