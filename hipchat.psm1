#Requires -Version 3.0

function Send-Hipchat {

    Param(
        # Required. The message body. 10,000 characters max.
        [Parameter(Mandatory = $True)][string]$message,
        
        # The background colour of the HipChat message. One of "yellow", "red", "green", "purple", "gray", or "random". (default: gray)
        [ValidateSet('yellow', 'green', 'red', 'purple', 'gray','random')][string]$color = 'gray',
        
        # Set whether or not this message should trigger a notification for people in the room. (default: false)
        [switch]$notify,
        
        # Required. This must be a HipChat API token created by a Room Admin for the room you are sending notifications to (default: API key for Test room).
        [Parameter(Mandatory = $True)][string]$apitoken,   
        
        # Required. The id or URL encoded name of the HipChat room you want to send the message to (default: Test).
        [Parameter(Mandatory = $True)][string]$room,
        
        # The number of times to try sending the message (default: 1)
        [int]$tries = 1,
        
        # The number of seconds to wait between tries (default: 30)
        [int]$retrysecs = 30
    )

    $authObj = @{
	    "Authorization" = "Bearer $($apitoken)";
	    "Content-type" = "application/json"
    }

    $messageObj = @{
        "message" = $message;
        "color" = $color;
        "notify" = [string]$notify
    }
                
    $uri = "https://api.hipchat.com/v2/room/$room/notification"    
    $body = ConvertTo-Json $messageObj

    $Stoploop = $false
    $Retrycount = 1
    $Result = $null
 
    While (!$Result -and $RetryCount -le $tries){
        $Retrycount++

	    try {
		    $Result = Invoke-WebRequest -Method Post -Uri $uri -Body $body -Headers $authObj -ErrorAction SilentlyContinue -TimeoutSec 1
		    Write-Verbose "'$message' sent"
		    Return $true
		    }
	    catch {

            $errormessage = $_
            Write-Verbose "Could not send message retrying in $retrysecs seconds..."
		    Start-Sleep -Seconds $retrysecs
	    }
    }

    If ($errormessage.ErrorDetails.Message -ne $null){
        Write-Error ($errormessage.ErrorDetails.Message | convertfrom-json).error.message
    }Else{
        Write-Verbose "Could not send after $retry retries. I quit."
		Write-Error $errormessage.Exception.message
	}

    Return $false
}