# Powershell Commands for HipChat
A module for Powershell with functions for interacting with the team chat tool "Hipchat" by Atlassian. The module utilises Hipchat API v2: https://www.hipchat.com/docs/apiv2.
> This script requires Powershell v3.0 or above.
## Functions
The following functions are available:
#### 1. Send-hipchat
For sending notifications into a room. Before you can use this you need to create an API v2 token for the room that you want to send notifications to. To do this:
1. Go to https://<your domain>.hipchat.com/admin/rooms/ and select the room you wish to notify.
2. Go to Tokens.
3. Create a Send Notification token. Note the "Label" you define will be included with the notification.

> **Beware, tokens here: https://<your domain>.hipchat.com/admin/api will not work, these are for API v1.**

##### Example
Attempt to send a message to a room named "My Room" coloured green. Will retry 5 additional times if it fails, waiting 30 seconds between each attempt. Will write verbose output to console.
```
send-hipchat -message "my message" -room "My%20Room" -apitoken a1b2c3d4e5f6a1b2c3d4e5f6 -color green -verbose -retry 5 -retrysec 30
```
## Acknowledgements
Thanks to **Sam Martin** for his support during the development of this tool. Check out his contributions here: https://github.com/Sam-Martin and his blog here https://sammart.in/.