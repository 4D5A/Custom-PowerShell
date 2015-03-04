# PowerShellModules

For the PowerShell modules to run you need to install a minimum of PowerShell version 2.

After verifying your version of PowerShell and before you attempt to run these PowerShell modules, check that your PowerShell Script Execution Policy is properly set.

To allow the execution of PowerShell scripts, open PowerShell as Administrator and run the below command.

```
Set-ExecutionPolicy Unrestricted
```

To set the PowerShell Execution Policy to its original configuration, open PowerShell as Administrator and run the below command.

```
Set-ExecutionPolicy Restricted
```

Move the directories to your user PowerShell profile ($HOME\Documents\WindowsPowerShell\Modules).

To use the modules run the commands below.

```
Import-Module Get-Base64
Import-Module Get-ExternalIP
```

To remove the modules run the commands below.

```
Remove-Module Get-Base64
Remove-Module Get-ExternalIP
```

For help run the below commands.

```
Get-Help Get-Base64 -full
Get-Help Get-ExternalIP -full
```


For more information about PowerShell Script Execution Policy execution options, read https://technet.microsoft.com/en-us/library/ee176961.aspx.

For more information about PowerShell Comment Based Help, read https://technet.microsoft.com/en-us/library/hh847834.aspx.
