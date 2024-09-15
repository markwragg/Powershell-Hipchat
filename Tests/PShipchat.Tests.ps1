Describe "Send-Hipchat" {


    BeforeAll {
        . $PSScriptRoot/../PSHipChat/Public/Send-Hipchat.ps1
        . $PSScriptRoot/../PSHipChat/Private/ConvertTo-Json.ps1
    
        Mock Invoke-WebRequest -ModuleName $moduleName { Import-Clixml "$pwd\Tests\PSHipchat.send-hipchat.invoke-webrequest.xml" }
    }

    It "should return true" {

        $params = @{
            message  = "Pester test message"
            room     = "Test"
            apitoken = "c6cS2qXSv1zRyUUXpPsu3bebVF43wx8bvPQK5vg6"
        }

        send-hipchat @params | Should -Be $true
    }

    It "should reject the colour blue" {

        $params = @{
            message  = "Pester test message"
            room     = "Test"
            apitoken = "fakefalsetoken"
            color    = "blue"
        }

        { send-hipchat @params } | Should -Throw
    }
}


Describe "Send-Hipchat timeouts" {
    
    BeforeAll {
        . $PSScriptRoot/../PSHipChat/Public/Send-Hipchat.ps1
        . $PSScriptRoot/../PSHipChat/Private/ConvertTo-Json.ps1

        Mock Invoke-WebRequest -ModuleName $moduleName { Throw }
    }
    
    It "should retry 3 additional times" {

        $params = @{
            message     = "Pester test message"
            room        = "Test"
            apitoken    = "fakefalsetoken"
            retry       = 3
            retrysecs   = 1
            ErrorAction = "SilentlyContinue"
        }

        send-hipchat @params | Should -Be $false
        Assert-MockCalled Invoke-WebRequest -Exactly 4 -ModuleName $moduleName -Scope It  
    }
}
