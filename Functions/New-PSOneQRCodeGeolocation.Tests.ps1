BeforeAll {
    Import-Module "$PSScriptRoot\..\loader.psm1" -Force
    $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PSOneQRCodeGeolocation' {
    AfterEach {
        $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        New-PSOneQRCodeGeolocation -Address 'Test'

        Get-Item $Global:defaultQrCodePath | Should -Exist
    }

    It 'throws when address is not found' {
        { New-PSOneQRCodeGeolocation -Address 'This is not an address' } | Should -Throw
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $byteArray = New-PSOneQRCodeGeolocation -Address 'Test' -AsByteArray

        $byteArray.Count | Should -Not -BeNullOrEmpty
        Test-Path $Global:defaultQrCodePath | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\..\loader.psm1" -Force -ErrorAction SilentlyContinue
}
