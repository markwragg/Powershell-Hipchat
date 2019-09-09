# Send-Hipchat

## SYNOPSIS
Sends messages to a Hipchat room.

## SYNTAX

```
Send-Hipchat [-message] <String> [[-color] <String>] [-notify] [-apitoken] <String> [-room] <String>
 [[-retry] <Int32>] [[-retrysecs] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Use this cmdlet to send a message in to a Hipchat room via the API.

## EXAMPLES

### EXAMPLE 1
```
Send-Hipchat -Message 'Hello' -Color 'Green' -Notify -ApiToken myapitoken -Room MyRoom -Retry 5 -RetrySec 10
```

Sends the specified message via the Hipchat API with the specified optional parameters.
If the message fails to send,
retries 5 times with a 10 second interval between each attempt.

## PARAMETERS

### -message
Required.
The message body.
10,000 characters max.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -color
The background colour of the HipChat message.
One of "yellow", "green", "red", "purple", "gray", or "random".
(default: gray)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Gray
Accept pipeline input: False
Accept wildcard characters: False
```

### -notify
Set whether or not this message should trigger a notification for people in the room.
(default: false)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -apitoken
Required.
This must be a HipChat API token created by a Room Admin for the room you are sending notifications to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -room
Required.
The id or URL encoded name of the HipChat room you want to send the message to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -retry
The number of times to retry sending the message (default: 0)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -retrysecs
The number of seconds to wait between tries (default: 30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### System.Boolean
## NOTES

## RELATED LINKS
