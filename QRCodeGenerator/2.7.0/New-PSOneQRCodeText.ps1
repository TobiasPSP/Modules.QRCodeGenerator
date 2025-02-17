function New-PSOneQRCodeText
{
    <#
            .SYNOPSIS
            Creates a QR code graphic containing for a Text

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - shows a text.

            .PARAMETER Text
            The Text to show
            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCodeText -Text tobiaspsp -Width 200 -Show -OutPath "$home\Desktop\qr.png"
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
        $Text,
        
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

    
    $payload = "$Text"

    New-PSOneQRCode -payload $payload -Show $Show -Width $Width -OutPath $OutPath -darkColorRgba $darkColorRgba -lightColorRgba $lightColorRgba
}