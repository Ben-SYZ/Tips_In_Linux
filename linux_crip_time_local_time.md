How to tell Manjaro to set the hardware clock to local time
Open up the Manjaro Settings Manager and click on "Time and date". Tick the checkbox labeled "Hardware clock in local timezone".
How to tell Microsoft Windows to set the hardware clock to UTC
Create a .reg file with the following content, and import it in Microsoft Windows by way of the Windows Registry Editor...:
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
"RealTimeIsUniversal"=dword:00000001
