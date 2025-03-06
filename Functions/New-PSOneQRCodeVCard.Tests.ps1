BeforeAll {
    Import-Module "$PSScriptRoot\..\loader.psm1" -Force
    (Get-DefaultQrCodePath) | Remove-Item -Force -ErrorAction SilentlyContinue
}

Describe 'New-PSOneQRCodeVCard' {
    AfterEach {
        (Get-DefaultQrCodePath) | Remove-Item -Force -ErrorAction SilentlyContinue
    }

    It 'defaults to file based output' {
        $splat = @{
            FirstName = 'Test'
            LastName  = 'Test'
            Company   = 'Test'
            Email     = 'tst@test.test'
        }
        New-PSOneQRCodeVCard @splat

        Get-Item (Get-DefaultQrCodePath) | Should -Exist
    }

    It 'returns the byte array when `-AsByteArray` switch is on' {
        $splat = @{
            FirstName   = 'Test'
            LastName    = 'Test'
            Company     = 'Test'
            Email       = 'tst@test.test'
            AsByteArray = $True
        }
        $byteArray = New-PSOneQRCodeVCard @splat

        $byteArray.Count | Should -Not -BeNullOrEmpty
        Test-Path (Get-DefaultQrCodePath) | Should -BeFalse
    }
}

AfterAll {
    Remove-Module "$PSScriptRoot\..\loader.psm1" -Force -ErrorAction SilentlyContinue
}
