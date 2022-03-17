<powershell>
Start-Transcript -Path C:\user-data.log

Enable-PSRemoting -force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -force
Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpListener $true
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5985
Restart-Service WinRM

Install-WindowsFeature -name Web-Server -IncludeManagementTools
Import-Module WebAdministration
Remove-Website -Name "Default Web Site"
New-Item -ItemType Directory -Name 'wwwroot' -Path 'C:\'
New-Item -ItemType File -Name 'index.html' -Path 'C:\wwwroot'
Add-Content -Path C:\wwwroot\index.html -Value '<!DOCTYPE html>
<html>
    <head>
         <title>Server 2 DEMO</title>
    </head>
    <body>
        <h1>Server 2 DEMO</h1>
        <p>Load Balancer is working well!</p>
    </body>
</html>'
New-WebAppPool -Name "NewAppPool"
New-WebSite -Name "wwwroot" -Port 80 -PhysicalPath "C:\wwwroot\" -ApplicationPool "NewAppPool"
New-NetFirewallRule -DisplayName "Allow Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow
Stop-Transcript
</powershell>