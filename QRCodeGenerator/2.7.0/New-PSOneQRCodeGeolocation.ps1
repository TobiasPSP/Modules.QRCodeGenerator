function New-PSOneQRCodeGeolocation
{
    <#
            .SYNOPSIS
            Creates a QR code graphic containing a geo location

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - opens the geo location in a browser.

            .PARAMETER Latitude
            The location latitude

            .PARAMETER Longitude
            The location longitude

            .PARAMETER Width
            Height and Width of generated graphics (in pixels). Default is 100.

            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCodeGeoLocation -Latitude 21.12 -Longitude 22.87 -Width 200 -Show -OutPath "$home\Desktop\qr.png"
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
        [Parameter(Mandatory,ParameterSetName='Location')]
        [double]
        $Latitude,

        [Parameter(Mandatory,ParameterSetName='Location')]
        [double]
        $Longitude,
        
        [Parameter(Mandatory,ParameterSetName='Address')]
        [string]
        $Address,

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

    if ($PSCmdlet.ParameterSetName -eq "Address")
    {
        $AddressEncoded = [System.Net.WebUtility]::UrlEncode($Address)
        $ApiUri = "http://nominatim.openstreetmap.org/search?q=$AddressEncoded&format=xml&addressdetails=1&limit=1"
        $Response = Invoke-RestMethod -Uri $ApiUri -UseBasicParsing

        $place = $Response.searchresults.place

        if ($null -eq $place)
        {
            throw "Address not found."
        }
        $Latitude =$place.lat
        $Longitude = $place.lon
    }
    
    $payload = @"
geo:$Latitude,$Longitude
"@
 
    New-PSOneQRCode -payload $payload -Show $Show -Width $Width -OutPath $OutPath -darkColorRgba $darkColorRgba -lightColorRgba $lightColorRgba
}