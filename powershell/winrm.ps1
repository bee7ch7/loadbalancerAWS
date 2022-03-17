<powershell>
Start-Transcript -Path C:\winrm.log
Enable-PSRemoting -force
Set-Item WSMan:\localhost\Client\TrustedHosts -Value * -force
Set-Item WSMan:\localhost\Service\EnableCompatibilityHttpListener $true
netsh advfirewall firewall add rule name="Windows Remote Management (HTTPS-In)" dir=in action=allow protocol=TCP localport=5985
Restart-Service WinRM
Stop-Transcript
</powershell>