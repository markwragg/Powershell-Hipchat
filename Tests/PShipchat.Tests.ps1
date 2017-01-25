$moduleName = 'PSHipchat'
$projectRoot = Resolve-Path "$PSScriptRoot\.."
$moduleRoot = Split-Path (Resolve-Path "$projectRoot\$moduleName\$moduleName.psm1")

Import-Module "$moduleRoot\$moduleName.psm1"

Describe "send-hipchat" {

    Mock Invoke-WebRequest -ModuleName $moduleName { Import-Clixml "$pwd\Tests\PSHipchat.send-hipchat.invoke-webrequest.xml" }
    
    It "should return true" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "c6cS2qXSv1zRyUUXpPsu3bebVF43wx8bvPQK5vg6"
        }

        send-hipchat @params | Should Be $true
    }

    It "should reject the colour blue" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "fakefalsetoken"
            color = "blue"
        }

        {send-hipchat @params} | Should Throw
    }
}


Describe "send-hipchat timeouts" {
    
    Mock Invoke-WebRequest -ModuleName $moduleName {Throw}

    It "should retry 3 additional times" {

        $params = @{
            message = "Pester test message"
            room = "Test"
            apitoken = "fakefalsetoken"
            retry = 3
            retrysecs = 1
            ErrorAction = "SilentlyContinue"
        }

        send-hipchat @params | Should be $false
        Assert-MockCalled Invoke-WebRequest -Exactly 4 -ModuleName $moduleName -Scope It
        
    }

}
