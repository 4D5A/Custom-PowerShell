import-module ActiveDirectory
$counter = 0
$nameselected = "no"
$name = "image"
$computername = "$name$counter"

Do { 
    Write-Host "Checking for existance of $computername."
    if (Get-ADComputer -Identity $computername) {
    Write-Host "Count is $counter."
    $global:counter++
    $computername = "$name$counter"
    Write-Host "New count is $counter."
    }
    }
    Until ( ( -not $( Get-ADComputer -Identity $computername)) )
        $nameslected = "yes"
    Write-Host "The name will be $computername."
    Write-Host "Replace this line with the with a function using the choosen computer name."