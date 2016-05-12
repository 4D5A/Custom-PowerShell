Add-Type -Path "C:\Program Files\Microsoft\Exchange\Web Services\2.0\Microsoft.Exchange.WebServices.dll"
add-pssnapin Microsoft.Exchange.Management.PowerShell.E2010
Get-DistributionGroup | Select-Object GroupType, Alias, OrganizationalUnit, PrimarySmtpAddress, WindowsEmailAddress | Export-Csv -NoTypeInformation  \\server\share\DistributionListReport.csv
$ImportCSV = import-csv "\\server\share\DistributionListReport.csv"
foreach ($line in $ImportCSV) {
    $Alias = $line.Alias
    Get-DistributionGroupMember $Alias | Select-Object Name | Export-Csv -NoTypeInformation \\server\share\membership_$Alias.csv
}