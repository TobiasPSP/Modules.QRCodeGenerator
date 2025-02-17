function New-PSOneQRCode
{
    <#
            .SYNOPSIS
            Creates a QR code graphic

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device

            .PARAMETER Payload
            The Payload for the QR code

            .PARAMETER Width
            Height and Width of generated graphics (in pixels). Default is 100.

            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCode -payload $payload -Width $width -Show -OutPath $OutPath
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
        $payload,

        [Parameter(Mandatory)]
        [bool]
        $Show,

        [ValidateRange(10,2000)]
        [int]
        $Width = 100,

        [string]
        $OutPath = "$env:temp\qrcode.png",

        [byte[]] 
        $DarkColorRgba = @(0,0,0),

        [byte[]]
        $LightColorRgba = @(255,255,255)
        
    )
        

    $generator = New-Object -TypeName QRCoder.QRCodeGenerator
    $data = $generator.CreateQrCode($payload, 'Q')
    $code = new-object -TypeName QRCoder.PngByteQRCode -ArgumentList ($data)
    $byteArray = $code.GetGraphic($Width, $darkColorRgba, $lightColorRgba)
    [System.IO.File]::WriteAllBytes($outPath, $byteArray)

    if ($Show) { Invoke-Item -Path $outPath }
}