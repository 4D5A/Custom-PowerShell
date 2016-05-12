function Get-Base64 {
    <#
        .Synopsis
            Base64 encodes or Base64 decodes a string.
        
        .Description
            Base64 encodes or Base64 decodes a string.

        .Notes
            N/A
            
        .Example
            Get-Base64 -String helloworld -e
            
        .Example
            Get-Base64 -String aGVsbG93b3JsZA== -d
    #>

Param(
    [string]$String,
    [switch]$e,
    [switch]$d
)

$encoding = [System.Text.Encoding]::ASCII
$convert = [System.Convert]

    If ($e)
        { # Convert string to Base64
            $Encoded = $encoding.GetBytes($String)
            $Encodedstring = $convert::ToBase64String($Encoded)
            Write-Output "String ($String) Base64 encoded is $EncodedString"
            $EncodedString | Set-Content ("$HOME\Desktop\EncodedStringOutput.txt")
        }
    
    If ($d)
        { # Convert Base64 to string
            $Decoded = $convert::FromBase64String($String)
            $Decodedstring = $encoding.GetString($Decoded)
            Write-Output "String ($String) Base64 decoded is $DecodedString"
            $DecodedString | Set-Content ("$HOME\Desktop\DecodedStringOutput.txt")
        }

}
