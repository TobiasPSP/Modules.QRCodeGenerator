BeforeAll {
    Import-Module "$PSScriptRoot\loader.psm1" -Force
    "$env:TEMP\qrcode.png" | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PsOneQRCode' {
    AfterEach {
        "$env:TEMP\qrcode.png" | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        New-PSOneQRCode -payload 'Test' -Show $False

        Get-Item "$env:TEMP\qrcode.png" | Should -Exist
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $byteArray = New-PSOneQRCode -payload 'Test' -Show $False -AsByteArray

        $byteArray.Count | Should -BeNullOrEmpty
        Test-Path "$env:TEMP\qrcode.png" | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\loader.psm1" -Force -ErrorAction SilentlyContinue
}
