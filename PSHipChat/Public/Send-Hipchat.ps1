function Send-Hipchat {
<#
.SYNOPSIS
    Sends messages to a Hipchat room.
.EXAMPLE
    Send-Hipchat -Message 'Hello' -Color 'Green' -Notify -ApiToken myapitoken -Room MyRoom -Retry 5 -RetrySec 10
#>
    [CmdletBinding()]
    [OutputType([Boolean])]
	Param(
        #Required. The message body. 10,000 characters max.
        [Parameter(Mandatory = $True)]
        [string]$message,
        
        #The background colour of the HipChat message. One of "yellow", "green", "red", "purple", "gray", or "random". (default: gray)
        [ValidateSet('yellow', 'green', 'red', 'purple', 'gray','random')]
        [string]$color = 'gray',
        
        #Set whether or not this message should trigger a notification for people in the room. (default: false)
        [switch]$notify,
        
        #Required. This must be a HipChat API token created by a Room Admin for the room you are sending notifications to.
        [Parameter(Mandatory = $True)]
        [string]$apitoken,   
        
        #Required. The id or URL encoded name of the HipChat room you want to send the message to.
        [Parameter(Mandatory = $True)]
        [string]$room,
        
        #The number of times to retry sending the message (default: 0)
        [int]$retry = 0,
        
        #The number of seconds to wait between tries (default: 30)
        [int]$retrysecs = 30
    )

    $messageObj = @{
        "message" = $message;
        "color" = $color;
        "notify" = [string]$notify
    }
             
    $uri = "https://api.hipchat.com/v2/room/$room/notification?auth_token=$apitoken"
    $Body = ConvertTo-Json $messageObj
    $Post = [System.Text.Encoding]::UTF8.GetBytes($Body)
        
    $Retrycount = 0
    
    While($RetryCount -le $retry){
	    try {
            if ($PSVersionTable.PSVersion.Major -gt 2 ){
                $Response = Invoke-WebRequest -Method Post -Uri $uri -Body $Body -ContentType "application/json" -ErrorAction SilentlyContinue            
            }else{                                   
                $Request = [System.Net.WebRequest]::Create($uri)
                $Request.ContentType = "application/json"
                $Request.ContentLength = $Post.Length
                $Request.Method = "POST"

                $requestStream = $Request.GetRequestStream()
                $requestStream.Write($Post, 0,$Post.length)
                $requestStream.Close()

                $Response = $Request.GetResponse()

                $stream = New-Object IO.StreamReader($Response.GetResponseStream(), $Response.ContentEncoding)
                $stream.ReadToEnd() | Out-Null
                $stream.Close()
                $Response.Close()
            }
            Write-Verbose "'$message' sent!"
            Return $true

        } catch {
            Write-Error "Could not send message: `r`n $_.Exception.ToString()"

             If ($retrycount -lt $retry){
                Write-Verbose "retrying in $retrysecs seconds..."
                Start-Sleep -Seconds $retrysecs
            }
        }
        $Retrycount++
    }
    
    Write-Verbose "Could not send after $Retrycount tries. I quit."
    Return $false
}