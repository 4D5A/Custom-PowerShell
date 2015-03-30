RC4 Encryptor Base64 Encoder
===========================
A special thanks goes to Remko Weijen who permitted me to use his RC4 function and example RC4 usage code in the rc4-b64.ps1 PowerShell script and to Doug Finke who permitted me to use code from his PowerShellTranslate PowerShell scripts.

Remko's original RC4 PowerShell function can be viewed on his blog www.remkoweijen.nl at http://www.remkoweijnen.nl/blog/2013/04/05/rc4-encryption-in-powershell/.
Doug's original PowerShellTranslate source can be viewed on his GitHub page at https://github.com/dfinke/PowerShellTranslate.



This project contains the following files:

b64DecodeaFile.ps1 - PowerShell Script that will decode a base64 encoded file.

b64EncodeaFile.ps1 - PowerShell Script that will base64 encode a file.

rc4-b64.ps1 - PowerShell Script that will RC4 encrypt then base64 encode a file. It will also base64 decode and RC4 decrypt a file if the RC4 encryption key is known.

For the PowerShell scripts to run you need to install a minimum of PowerShell version 2.

After verifying your version of PowerShell and before you attempt to run these PowerShell scripts, check that your PowerShell Script Execution Policy is properly set.

To allow the execution of PowerShell scripts, open PowerShell as Administrator and run the below command.

Set-ExecutionPolicy Unrestricted

To set the PowerShell Execution Policy to its original configuration, open PowerShell as Administrator and run the below command.

Set-ExecutionPolicy Restricted

For more information about PowerShell Script Execution Policy execution options, read https://technet.microsoft.com/en-us/library/ee176961.aspx.

