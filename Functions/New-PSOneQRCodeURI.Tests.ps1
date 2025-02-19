BeforeAll {
    Import-Module "$PSScriptRoot\..\loader.psm1" -Force
    $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PSOneQRCodeURI' {
    AfterEach {
        $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        New-PSOneQRCodeURI -URI 'http://127.0.0.1'

        Get-Item $Global:defaultQrCodePath | Should -Exist
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $byteArray = New-PSOneQRCodeURI -URI 'http://127.0.0.1' -AsByteArray

        $byteArray.Count | Should -Not -BeNullOrEmpty
        Test-Path $Global:defaultQrCodePath | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\..\loader.psm1" -Force -ErrorAction SilentlyContinue
}
