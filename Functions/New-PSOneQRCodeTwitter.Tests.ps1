BeforeAll {
    Import-Module "$PSScriptRoot\..\loader.psm1" -Force
    (Get-DefaultQrCodePath) | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PSOneQRCodeTwitter' {
    AfterEach {
        (Get-DefaultQrCodePath) | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        New-PSOneQRCodeTwitter -ProfileName 'Test'

        Get-Item (Get-DefaultQrCodePath) | Should -Exist
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $byteArray = New-PSOneQRCodeTwitter -ProfileName 'Test' -AsByteArray

        $byteArray.Count | Should -Not -BeNullOrEmpty
        Test-Path (Get-DefaultQrCodePath) | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\..\loader.psm1" -Force -ErrorAction SilentlyContinue
}
