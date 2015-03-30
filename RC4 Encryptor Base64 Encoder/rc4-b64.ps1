function New-TranslationTable {
    <#
        .Synopsis
            Returns a translation table
        .Description
            Returns a translation table that maps each character in the InputTable
            string into the character at the same position in the OutputTable string.
            Then this table is passed to Invoke-Translate.

        .Notes
            Both InputTable and OutputTable must have the same length.
        .Example
            $InputTable = "aeiou"
            $OutputTable = "12345"
            $TranslationTable = New-TranslationTable $InputTable $OutputTable

            $string = "this is string example....wow!!!";

            Invoke-Translate -TargetString $string -TranslationTable $TranslationTable

            th3s 3s str3ng 2x1mpl2....w4w!!!
    #>
    param(
        # This is the string having actual characters.
        [string]$Standard,
        # This is the string having corresponding mapping character.
        [string]$Custom
    )

    $count = $Standard.Length
    $h = @{}
    for($idx=0; $idx -lt $count; $idx+=1) {
        $h[$Standard[$idx]]=$Custom[$idx]
    }
    return $h
}

function Invoke-Translate {
    <#
        .Synopsis
            Returns a string in which all characters have been translated using Translation Table
        .Description
            Returns a string in which all characters have been translated using Translation Table
            (constructed with the New-TranslationTable),
            optionally deleting all characters found in the string DeleteChars.
        .Example
            $InputTable = "aeiou"
            $OutputTable = "12345"
            $TranslationTable = New-TranslationTable $InputTable $OutputTable

            $string = "this is string example....wow!!!";

            Invoke-Translate -TargetString $string -TranslationTable $TranslationTable

            th3s 3s str3ng 2x1mpl2....w4w!!!
        .Example
            $InputTable = "aeiou"
            $OutputTable = "12345"
            $TranslationTable = New-TranslationTable $InputTable $OutputTable

            $string = "this is string example....wow!!!";

            Invoke-Translate -TargetString $string -TranslationTable $TranslationTable -DeleteChars 'xm'

            th3s 3s str3ng 21pl2....w4w!!!
    #>
    param(
        [string]$TargetString,
        # Use the New-TranslationTable create a translation table.
        [hashtable]$TranslationTable,
        # The list of characters to be removed from the source string.
        [string]$DeleteChars
    )

    if($DeleteChars) {
        $replace = $DeleteChars.ToCharArray() -join '|'
        $TargetString = $TargetString -replace $replace, ''
    }

    $count = $TargetString.Length
    $result = ""

    for($idx=0; $idx -lt $count; $idx+=1) {

        $char = $TargetString[$idx]
        $found = $TranslationTable[$char]

        if($found) {
            $result+=$found
        } else {
            $result+=$char
        }
    }

    $result
}

function rc4 {
	param(
    	[Byte[]]$data,
    	[Byte[]]$key
  	)

	# Make a copy of the input data
	[Byte[]]$buffer = New-Object Byte[] $data.Length
	$data.CopyTo($buffer, 0)
	
	[Byte[]]$s = New-Object Byte[] 256;
    [Byte[]]$k = New-Object Byte[] 256;

    for ($i = 0; $i -lt 256; $i++)
    {
        $s[$i] = [Byte]$i;
        $k[$i] = $key[$i % $key.Length];
    }

    $j = 0;
    for ($i = 0; $i -lt 256; $i++)
    {
        $j = ($j + $s[$i] + $k[$i]) % 256;
        $temp = $s[$i];
        $s[$i] = $s[$j];
        $s[$j] = $temp;
    }

    $i = $j = 0;
    for ($x = 0; $x -lt $buffer.Length; $x++)
    {
        $i = ($i + 1) % 256;
        $j = ($j + $s[$i]) % 256;
        $temp = $s[$i];
        $s[$i] = $s[$j];
        $s[$j] = $temp;
        [int]$t = ($s[$i] + $s[$j]) % 256;
        $buffer[$x] = $buffer[$x] -bxor $s[$t];
    }

	return $buffer
}

$Standard = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
$Custom = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ+/"

$Direction = 0

# If you are going to encode the information using the default base64 alphabet set $Direction to 0.
If($Direction -eq 0)
 {
$TranslationTable = New-TranslationTable $Standard $Standard
 }
 
# If you are going to encode the information using the custom base64 alphabet set $Direction to 1.
If($Direction -eq 1)
 {
$TranslationTable = New-TranslationTable $Standard $Custom
 }

# If you are going to decode the information using the custom base64 alphabet set $Direction to 2.
If($Direction -eq 2)
 {
$TranslationTable = New-TranslationTable $Custom $Standard
 }
  

$fileName = "originalfile.txt"
$fileContent = Get-Content $fileName

$encode = [System.Text.Encoding]::ASCII
# The data we're going to encrypt
[Byte[]]$data = $encode.GetBytes($fileContent)
# The key we're going to use
[Byte[]]$key = $encode.GetBytes("pass code")

# Encrypt the data, a byte array is returned
$EncryptedBytes = rc4 $data $key
$EncryptedBytes | Set-Content ("EncryptedBytes.txt")

# Base64 Encode the Encrypted Bytes and convert the byte array into a hex string so we eg save it to disk
$b64EncodedEncryptedString = [System.Convert]::ToBase64String($EncryptedBytes)
$b64EncodedEncryptedString = Invoke-Translate $b64EncodedEncryptedString $TranslationTable
$b64EncodedEncryptedString | Set-Content ("b64EncodedEncryptedString.txt")

# Decode the base64 Encoded Encrypted String
$b64DecodedEncryptedString = Invoke-Translate $b64EncodedEncryptedString $TranslationTable
$b64DecodedEncryptedBytes = [System.Convert]::FromBase64String($b64EncodedEncryptedString)
$b64DecodedEncryptedBytes | Set-Content ("b64DecodedEncryptedBytes.txt")

# Now decrypt the data
$DecryptedBytes = rc4 $b64DecodedEncryptedBytes $key

# Convert the byte array into a hex string so we eg save it to disk
$DecryptedString = $encode.GetString($DecryptedBytes)
$DecryptedString | Set-Content ("DecryptedString.txt")