function New-PSOneQRCodeVCard
{
    <#
            .SYNOPSIS
            Creates a QR code graphic containing person data

            .DESCRIPTION
            Creates a QR code graphic in png format that - when scanned by a smart device - adds a contact to the address book.

            .PARAMETER FirstName
            Person first name

            .PARAMETER LastName
            Person last name

            .PARAMETER Company
            Company name

            .PARAMETER Email
            email address

            .PARAMETER Width
            Height and Width of generated graphics (in pixels). Default is 100.

            .PARAMETER Show
            Opens the generated QR code in associated program

            .PARAMETER OutPath
            Path to generated png file. When omitted, a temporary file name is used.

            .EXAMPLE
            New-PSOneQRCodeVCard -FirstName Tom -LastName Sawyer -Company "Huckle Inc." -Email t.sawyer@huckle.com -Width 200 -Show -OutPath "$home\Desktop\qr.png"
            Creates a QR code png graphics on your desktop, and opens it with the associated program

            .NOTES
            Compatible with all PowerShell versions including PowerShell 6/Core
            Uses binaries from https://github.com/codebude/QRCoder/wiki

            .LINK
            https://github.com/TobiasPSP/Modules.QRCodeGenerator
    #>


    param
    (
        [Parameter(Mandatory)]
        [string]
        $FirstName,

        [Parameter(Mandatory)]
        [string]
        $LastName,

        [Parameter(Mandatory)]
        [string]
        $Company,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]
        $Email,
        
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

    $Name = "$FirstName $LastName"

    $payload = @"
BEGIN:VCARD
VERSION:3.0
KIND:individual
N:$LastName;$FirstName
FN:$Name
ORG:$Company
EMAIL;TYPE=INTERNET:$Email
END:VCARD
"@
    
    New-PSOneQRCode -payload $payload -Show $Show -Width $Width -OutPath $OutPath -darkColorRgba $darkColorRgba -lightColorRgba $lightColorRgba
}
