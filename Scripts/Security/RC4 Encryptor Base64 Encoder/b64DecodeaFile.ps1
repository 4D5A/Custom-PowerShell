$decode = [System.Text.Encoding]::ASCII
$convert = [System.Convert]
$fileName = "b64encodedfile.txt"
$fileContent = Get-Content $fileName
$fileContentDecoded = $convert::FromBase64String($fileContent)
$fileContentDecoded = $decode.GetString($fileContentDecoded)
$fileContentDecoded | Set-Content ("b64decodedfile.txt")