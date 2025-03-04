BeforeAll {
    Import-Module "$PSScriptRoot\..\loader.psm1" -Force
    $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PsOneQRCode' {
    AfterEach {
        $Global:defaultQrCodePath | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        New-PSOneQRCode -payload 'Test' -Show $False

        Get-Item $Global:defaultQrCodePath | Should -Exist
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $byteArray = New-PSOneQRCode -payload 'Test' -Show $False -AsByteArray

        $byteArray.Count | Should -Not -BeNullOrEmpty
        Test-Path $Global:defaultQrCodePath | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\..\loader.psm1" -Force -ErrorAction SilentlyContinue
}
