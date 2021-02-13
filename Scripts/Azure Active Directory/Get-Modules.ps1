[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
Import-Module -Name AzureAD -ErrorAction:SilentlyContinue -UseWindowsPowerShell
If (-Not (Get-Module -Name AzureAD)) {
    ./New-Modules.ps1
}
If (Get-Module -Name AzureAD) {
    ./Import-Modules.ps1
}