import-module ActiveDirectory
$counter = 0
$nameselected = "no"
$server = "image$counter"
$ErrorActionPreference = 'SilentlyContinue'

Do { 
    Write-Host "Checking for existance of $server."
    if (Get-ADComputer -Identity $server) {
    Write-Host "Count is $counter."
    $global:counter++
    $server = "image$counter"
    Write-Host "New count is $counter."
    }
    }
    Until ( ( -not $( Get-ADComputer -Identity $server)) )
        $nameslected = "yes"
    Write-Host "The name will be $server."
    Write-Host "Replace this line with the with your function for chaning DNS or joining the domain."