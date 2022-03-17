# loadbalancerAWS
Terraform to setup 2x windows servers with IIS and configure AWS ELB

To get a powershell access from Windows machine to the fresh created AWS Instances:
```
winrm quickconfig -transport:https
netsh firewall add portopening TCP 5986 "WinRM over HTTPS"
Set-Item wsman:localhost\client\trustedhosts -value <aws_instance_ip_1>
Set-Item wsman:localhost\client\trustedhosts -value <aws_instance_ip_2>


enter-pssession -computername <aws_instance_ip_1> -Credential(get-credential)
```
By the commands above we create firewall rule for WinRM and adding IPs to the trusted hosts

