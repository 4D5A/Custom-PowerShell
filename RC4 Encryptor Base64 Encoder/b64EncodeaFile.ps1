$encode = [System.Text.Encoding]::ASCII
$convert = [System.Convert]
$fileName = "originalfile.txt"
$fileContent = Get-Content $fileName
$fileContentBytes = $encode.GetBytes($fileContent)
$fileContentEncoded = $convert::ToBase64String($fileContentBytes)
$fileContentEncoded | Set-Content ("b64encodedfile.txt")