function New-PSOneQRCodeWifiAccess
{
    <#
            .SYNOPSIS
            Creates a QR code graphic containing a Wifi access

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - connects you to a Wifi access point

            .PARAMETER SSID
            The Wifi ssid name

            .PARAMETER Password
            The Wifi access point password

            .PARAMETER AuthenticationMode
            The Wifi access point Authentication Mode (nopass, WEP, WPA)
            WPA also is WPA2

            .PARAMETER Width
            Height and Width of generated graphics (in pixels). Default is 100.

            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCodeWifiAccess -SSID InternetCafe -Password TopSecret123 -Width 200 -Show -OutPath "$home\Desktop\qr.png"
            Creates a QR code png graphics on your desktop, and opens it with the associated program

            .NOTES
            Compatible with all PowerShell versions including PowerShell 6/Core
            Uses binaries from https://github.com/codebude/QRCoder/wiki

            .LINK
            https://github.com/TobiasPSP/Modules.QRCodeGenerator
    #>

    [CmdletBinding(DefaultParameterSetName="Address")]
    param
    (
        [Parameter(Mandatory)]
        [string]
        $SSID,

        [string]
        $Password,

        [Parameter(Mandatory)]
        [Authentication]
        $AuthenticationMode,

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
        
    switch ($authenticationMode) {
        WEP { $Authentication = [QRCoder.PayloadGenerator+WiFi+Authentication]::WEP; break}
        WPA { $Authentication = [QRCoder.PayloadGenerator+WiFi+Authentication]::WPA; break}
        Default {
            $Authentication =  [QRCoder.PayloadGenerator+WiFi+Authentication]::nopass
            $password = "" 
        }
    }
    
    $payload = New-Object -TypeName QRCoder.PayloadGenerator+WiFi -ArgumentList ($SSID, $password, $Authentication)
   
    New-PSOneQRCode -payload $payload -Show $Show -Width $Width -OutPath $OutPath -darkColorRgba $darkColorRgba -lightColorRgba $lightColorRgba
}
