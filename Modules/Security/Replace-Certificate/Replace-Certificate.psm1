    <#
        .Synopsis
            Removes, adds, or replaces a certificate.
        
        .Description
            Removes, adds, or replaces a certificate in the location specified when the command is run.

        .Notes
            N/A
            
        .Example
            This example deletes a certificate by thumbprint.
            
            Replace-Certificate -deletecertificate XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            
        .Example
            This example deletes a certificate by subject. CAUTION: This will delete all certificates that are like www.example.com. Please read https://technet.microsoft.com/en-us/library/hh847759.aspx for additional information on how PowerShell processes information compared with the -like operator.
            
            Replace-Certificate -deletebysubject -deletecertificate www.example.com
        
        .Example
            This example adds a certificate.
            
            Replace-Certificate -addcertificate "C:\folder\folder\certificate.cer"
            
        .Example
            This example replaces a cerficate using the thumbprint to delete the certificate.
            
            Replace-Certificate -deletecertificate XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX -addcertificate "C:\folder\folder\certificate.cer"
            
        .Example
            This example replaces a cerficate using the subject to delete the certificate. CAUTION: This will delete all certificates that are like www.example.com. Please read https://technet.microsoft.com/en-us/library/hh847759.aspx for additional information on how PowerShell processes information compared with the -like operator.
            
            Replace-Certificate -deletebysubject -deletecertificate www.example.com -addcertificate "C:\folder\folder\certificate.cer"
    #>
    
function Replace-Certificate {

Param(
    [parameter(Mandatory=$False)]
        [String]$deletecertificate,
    [parameter(Mandatory=$False)]
        [Switch]$deletebysubject,
    [parameter(Mandatory=$False)]
        [String]$addcertificate
)

#Set the Root Location. This can be "CurrentUser" or "LocalMachine".
$parent = "CurrentUser"

#Set the second level location.
#Set the value for the Current User Location. This can be "SmartCardRoot", "UserDS", "AuthRoot", "CA", "ADDRESSBOOK", "Trust", "Disallowed", "My", "Root", "TrustedPeople", or "TrustedPublisher".
$CurrentUserLocation = "My"

#Set the value for the Local Machine Location. This can be "SmartCardRoot", "AuthRoot", "CA", "Trust", "Disallowed", "My", "Root", "TrustedDevices", "TrustedPeople", "TrustedPublisher", or "Homegroup Machine Certificates".
$LocalMachineLocation = "My"


If ($parent = "CurrentUser") {
    $child = $CurrentUserLocation
    }
Elseif ($parent = "LocalMachine") {
    $child = $LocalMachineLocation
    }
    
    
$CertPSDrive = New-Object System.Security.Cryptography.x509Certificates.x509Store $child,$parent
$CertPSDrive.Open('ReadWrite')

If ($deletecertificate) {
    If ($deletebysubject) {
        $storedcertificates = @(dir cert:\$parent\$child | ? { $_.Subject -like "*$deletecertificate*" })
        foreach ($certificates in $storedcertificates) {$CertPSDrive.Remove($certificates)}
        }
    Else {
        $storedcertificates = @(dir cert:\$parent\$child | ? { $_.Thumbprint -eq $deletecertificate })
        foreach ($certificates in $storedcertificates) {$CertPSDrive.Remove($certificates)}
    }
}

If ($addcertificate) {
    $CertPSDrive.add($addcertificate)
    }

$CertPSDrive.close()


}