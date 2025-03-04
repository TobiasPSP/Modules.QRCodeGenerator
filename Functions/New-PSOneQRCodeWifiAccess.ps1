function New-PSOneQRCodeWifiAccess {
    <#
            .SYNOPSIS
            Creates a QR code graphic containing a Wifi access

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - connects you to a Wifi access point

            .PARAMETER SSID
            The Wifi ssid name

            .PARAMETER Password
            The Wifi access point password

            .PARAMETER Width
            Height and Width of generated graphics (in pixels). Default is 100.

            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .PARAMETER AsByteArray
            Returns the byte array data for in memory processing.

            .EXAMPLE
            New-PSOneQRCodeWifiAccess -SSID InternetCafe -Password TopSecret123 -Width 200 -Show -OutPath "$home\Desktop\qr.png"
            Creates a QR code png graphics on your desktop, and opens it with the associated program

            .NOTES
            Compatible with all PowerShell versions including PowerShell 6/Core
            Uses binaries from https://github.com/codebude/QRCoder/wiki

            .LINK
            https://github.com/TobiasPSP/Modules.QRCodeGenerator
    #>

    [CmdletBinding(DefaultParameterSetName = 'File')]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $SSID,

        [Parameter(Mandatory)]
        [string]
        $Password,

        [ValidateRange(10, 2000)]
        [int]
        $Width = 100,

        [Switch]
        $Show,

        [Parameter(ParameterSetName = 'File')]
        [string]
        $OutPath = $Global:defaultQrCodePath,
        
        [Parameter(ParameterSetName = 'ByteArray')]
        [switch]
        $AsByteArray,
        
        [byte[]] 
        $DarkColorRgba = @(0, 0, 0),

        [byte[]]
        $LightColorRgba = @(255, 255, 255)
    )
        
    $payload = @"
WIFI:S:$SSID;T:WPA2;P:$Password;;
"@

    $splat = @{
        payload        = $payload
        Show           = $Show
        Width          = $Width
        OutPath        = $OutPath
        darkColorRgba  = $darkColorRgba
        lightColorRgba = $lightColorRgba
    }

    if ($PSCmdlet.ParameterSetName -match 'ByteArray') {
        $splat.Add('AsByteArray', $true)
        $splat.Remove('OutPath')
        $splat.Show = $False
    }

    New-PSOneQRCode @splat
}
