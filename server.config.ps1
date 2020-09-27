#sets the user's locale 
function Set-UserLocale {
    #Set Timezone
    Set-Timezone -Id "Romance Standard Time"
    #Set Input Language
    Set-WinUserLanguageList -LanguageList nl-BE, en-BE -Force
    #set Windows Country Location
    Set-WinHomeLocation 21
}
Set-UserLocale

#disable firewall
function Disable-Firewall {
    Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
    Write-Host "Windows Firewall has been disabled." -ForegroundColor Green
}
Disable-Firewall

#enable RDP & setup NLA
function Enable-RDP {
    reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
    Write-Host "RDP has been enabled." -ForegroundColor Green
}
Enable-RDP

#uninstall Windows Defender
function Disable-WindowsDefender {
    Uninstall-WindowsFeature -Name Windows-Defender
    Write-Host "Windows Defender has been removed." -ForegroundColor Green
}
Disable-WindowsDefender

#disable IE enhanced security configuration
function Disable-ieESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0
    Stop-Process -Name Explorer
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
Disable-ieESC

#Option to show the file extensions in Explorer
function Show-Filextensions {
    Push-Location
    Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
    Set-ItemProperty . HideFileExt "0"
    Pop-Location
}
Show-Filextensions

#Install .NET Framework 3.5
function EnableNET35 {
    Install-WindowsFeature Net-Framework-Core
    Write-Host ".NET Framework 3.5 has been installed." -ForegroundColor Green
}
EnableNET35

#Install Telnet client
function EnableTelnetClient{
    Install-WindowsFeature -name Telnet-Client
    Write-Host "Telnet client has been installed." -ForegroundColor Green
}
EnableTelnetClient

#wait on keypress
Read-Host -Prompt "Press Enter to exit"

#should be obvious :)
Restart-Computer