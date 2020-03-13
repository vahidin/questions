rem "вариант для просмотра открытых портов"
netstat -an |find /i "listening"

rem "ОТКРЫТЬ"
netsh firewall set portopening tcp 23 smb enable
netsh advfirewall firewall add rule name="Open Port 443" dir=in action=allow protocol=TCP localport=443

rem "Закрыть"
netsh firewall set portopening tcp 23 smb disable
netsh advfirewall firewall delete rule name="Open Port 443" protocol=TCP localport=443
