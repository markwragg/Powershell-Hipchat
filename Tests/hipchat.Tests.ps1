$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = 'hipchat.psd1'
import-module "$here\$sut" -force


Describe "send-hipchat" {

    Mock Invoke-WebRequest -ModuleName "hipchat" {Import-Clixml "hipchat.send-hipchat.invoke-webrequest.xml"}
    
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
            #apitoken = "c6cS2qXSv1zRyUUXpPsu3bebVF43wx8bvPQK5vg6"
            apitoken = "blah"
            color = "blue"
        }

        {send-hipchat @params} | Should Throw
    }
}


Describe "send-hipchat timeouts" {
    
    Mock Invoke-WebRequest -ModuleName "hipchat" {Throw}

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
        Assert-MockCalled Invoke-WebRequest -Exactly 4 -ModuleName "hipchat" -Scope It
        
    }

}
