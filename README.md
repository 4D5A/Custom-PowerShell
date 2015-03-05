# PowerShellModules

For the PowerShell modules to run you need to install a minimum of PowerShell version 2.

To download a module, save the module directory to $HOME (%userprofile%) \Documents\WindowsPowerShell\Modules. This directory is part of the $PATH for PowerShell. After verifying your version of PowerShell and before you attempt to run these PowerShell modules, check that your PowerShell Script Execution Policy is properly set.

To allow the execution of PowerShell scripts, open PowerShell as Administrator and run the below command.

```
Set-ExecutionPolicy Unrestricted
```

To set the PowerShell Execution Policy to its original configuration, open PowerShell as Administrator and run the below command.

```
Set-ExecutionPolicy Restricted
```

Move the directories to your user PowerShell profile ($HOME\Documents\WindowsPowerShell\Modules).

To import a module run the command below.

```
Import-Module *modulename*
```

So if you are importing a module named Get-Example the command would be -

```
Import-Module Get-Example
```

To remove a module run the command below.

```
Remove-Module *modulename*
```

So if you are removing a module named Get-Example the command would be -

```
Remove-Module Get-Example
```


To display the help for a module run the command below.

```
Get-Help *modulename* -full
```

So if you want to display the help information for a module named Get-Example the command would be -

```
Get-Help Get-Example -full
```


For more information about PowerShell Script Execution Policy execution options, read https://technet.microsoft.com/en-us/library/ee176961.aspx.

For more information about Installing PowerShell Modules, read
https://msdn.microsoft.com/en-us/library/dd878350.aspx.

For more information about PowerShell Comment Based Help, read https://technet.microsoft.com/en-us/library/hh847834.aspx.
