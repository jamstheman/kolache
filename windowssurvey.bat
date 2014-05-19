@ECHO OFF
rem ''''''''''''''''''''''''''''''''''''''''''''''''''
rem '         Brought to you by Mike Morris          '
rem ''''''''''''''''''''''''''''''''''''''''''''''''''
rem This script will conduct an initial survey of the target environment
rem tested on XP SP0 Pro, XP SP2 Pro, Win7, Vista
title Initial Survey
color 0a 
mode con lines=25000
mode con cols=90

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #   YOUR WINDOWS SURVEY IS ABOUT TO BEGIN        #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 
pause;

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      PROCESS LIST WITH MEMORY USAGE STATS      #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 
pause;

cmd.exe /c tasklist | more

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #         CURRENT WORKING DIRECTORY              #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c chdir
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #               CHANGING DIRECTORIES             #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cd %systemdrive%\progra~1\common~1\system

pause;
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #         CURRENT WORKING DIRECTORY              #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c chdir
cmd.exe /c echo.

pause; 

ver | find "2003" > nul
if %ERRORLEVEL% == 0 goto ver_pre-vista

ver | find "XP" > nul
if %ERRORLEVEL% == 0 goto ver_pre-vista

ver | find "2000" > nul
if %ERRORLEVEL% == 0 goto ver_pre-vista

ver | find "NT" > nul
if %ERRORLEVEL% == 0 goto ver_pre-vista

rem if not exist %SystemRoot%\system32\systeminfo.exe goto warnthenexit

rem systeminfo | find "OS Name" > %TEMP%\osname.txt
for /f "tokens=3*" %%i IN ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| Find "ProductName"') DO set vers=%%i %%j

echo %vers% | find "Windows 7" > nul
if %ERRORLEVEL% == 0 goto ver_post-vista

echo %vers% | find "Windows Server 2008" > nul
if %ERRORLEVEL% == 0 goto ver_post-vista

echo %vers% | find "Windows Vista" > nul
if %ERRORLEVEL% == 0 goto ver_post-vista

rem goto warnthenexit

:ver_pre-vista
:Run Windows 2000 specific commands here.
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           CONFIRMING LAST BOOT TIME            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c netsh diag show os /v | find "LastBootUpTime"
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                Checking User                   #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c echo. 
cmd.exe /c echo %USERDOMAIN%\%USERNAME%
cmd.exe /c echo %WINDIR%
cmd.exe /c echo. 

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                  OS Check                      #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

cmd.exe /c "echo >OSVer.vbs Set OSSet = GetObject("winmgmts:{impersonationLevel=impersonate}!//./root/cimv2").ExecQuery("select caption, CSDVersion, SerialNumber from Win32_OperatingSystem")"

cmd.exe /c "echo >>OSVer.vbs For Each OS In OSSet"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Operating System=" ^& OS.Caption"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Service Pack=" ^& OS.CSDVersion"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Product ID=" ^& OS.SerialNumber"

cmd.exe /c "echo >>OSVer.vbs Next"

cmd.exe /c "cscript //nologo OSVer.vbs"

cmd.exe /c del OSVer.vbs

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            32 or 64-bit Check                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

Set RegQry=HKLM\Hardware\Description\System\CentralProcessor\0
 
REG.exe Query %RegQry% > checkOS.txt
 
Find /i "x86" < CheckOS.txt > StringCheck.txt
 
If %ERRORLEVEL% == 0 (
    Echo "This is a 32-bit Operating system"
) ELSE (
    Echo "This is a 64-bit Operating System"
)

cmd.exe /c del StringCheck.txt
cmd.exe /c del checkOS.txt

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #         CURRENT WORKING DIRECTORY              #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c chdir
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #              TARGET DATE\TIME                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c echo The TIME is: %time%
cmd.exe /c echo The DATE is: %date%
cmd.exe /c netsh diag show os /v | find "LocalDateTime"
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #               TARGET OS INFORMATION            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c netsh diag show os /v | find "Operating System"
cmd.exe /c netsh diag show os /v | find "CSName"
cmd.exe /c netsh diag show os /v | find "InstallDate"
cmd.exe /c netsh diag show os /v | find "SerialNumber"
cmd.exe /c netsh diag show os /v | find "RegisteredUser"
cmd.exe /c netsh diag show computer /v | find "PrimaryOwnerContact"
cmd.exe /c netsh diag show computer /v | find "PrimaryOwnerName"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            TARGET PLATFORM INFORMATION         #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c netsh diag show computer /v | find "Manufacturer"
cmd.exe /c netsh diag show computer /v | find "Model"
cmd.exe /c netsh diag show computer /v | find "Name"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            TARGET USER INFORMATION             #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c netsh diag show computer /v | find "AdminPasswordStatus"
cmd.exe /c echo      1=Disabled, 2=Enabled, 3=Not Implemented, 4=Unknown
cmd.exe /c netsh diag show computer /v | find "UserName"
cmd.exe /c netsh diag show computer /v | find "Caption"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            TARGET NETWORKING INFORMATION       #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c netsh diag show computer /v | find "Name"
cmd.exe /c netsh diag show computer /v | find "Domain"
cmd.exe /c netsh diag show computer /v | find "DomainRole"
cmd.exe /c echo VALUE MEANS 0=Standalone, 1=Member, 2=Standalone Server, 3=Member Server, 4=BDC, 5=PDC
cmd.exe /c netsh diag show computer /v | find "PartOfDomain"
cmd.exe /c netsh diag show computer /v | find "Roles"
cmd.exe /c netsh diag show computer /v | find "Workgroup"
cmd.exe /c netsh diag show os /v | find "NumberOfUsers"
cmd.exe /c netsh diag show os /v | find "NumberOfProcesses"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      CHECKING COMPUTER'S PUBLIC IP ADDRESS     #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause;

rem wget -q -O - http://www.showmyip.com/simple/

cmd.exe /c echo var request = new ActiveXObject("Msxml2.XMLHTTP"); > ext_ip.js
cmd.exe /c echo var notyetready = 1; >> ext_ip.js

cmd.exe /c echo request.onreadystatechange=function() >> ext_ip.js 
cmd.exe /c echo { >> ext_ip.js
cmd.exe /c echo if(request.readyState==4) >> ext_ip.js
cmd.exe /c echo { >> ext_ip.js
cmd.exe /c echo WScript.Echo(request.responseText); >> ext_ip.js 
cmd.exe /c echo notyetready = 0; >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js
cmd.exe /c echo. >> ext_ip.js
cmd.exe /c echo request.open( "GET", "http://www.whatismyip.com/automation/n09230945.asp", true ); >> ext_ip.js 
cmd.exe /c echo request.send(null); >> ext_ip.js 
cmd.exe /c echo. >> ext_ip.js
cmd.exe /c echo while( notyetready ) >> ext_ip.js 
cmd.exe /c echo { >> ext_ip.js 
cmd.exe /c echo WScript.Sleep( 100 ); >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js 

cmd.exe /c cscript ext_ip.js

cmd.exe /c del ext_ip.js

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW CHECKING NETWORK CONNECTION INFO      #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c netstat -an 
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #   NOW CHECKING NETWORK INTERFACE INFORMATION   #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c ipconfig /all
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW CHECKING NETWORK ROUTING INFO         #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c route print
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            NOW CHECKING ARP INFO               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

cmd.exe /c arp -a 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY NETWORK SHARES                #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause; 
cmd.exe /c net share
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY LOCAL USER ACCOUNTS           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause;
cmd.exe /c net user
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY LOCAL GROUPS                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause;
cmd.exe /c net localgroup
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #   NOW DISPLAY USERS BELONGING TO ADMIN GROUP   #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause;
cmd.exe /c net localgroup administrators
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY COMPUTERS IN MY WORKGROUP     #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause;
cmd.exe /c net view
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY DOMAIN INFO                   #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause;
cmd.exe /c net view /domain

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #             Checking Eventlogs                 #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c cscript %SYSTEMroot%\system32\eventquery.vbs /L security | more

pause; 

cmd.exe /c cscript %SYSTEMroot%\system32\eventquery.vbs /L system | more

pause; 

cmd.exe /c cscript %SYSTEMroot%\system32\eventquery.vbs /L application | more

pause; 

cmd.exe /c echo.
cmd.exe /c echo ######################################################
cmd.exe /c echo #    IF YOU WOULD LIKE A MORE VERBOSE OUTPUT RUN     #
cmd.exe /c echo #     "eventquery /L <logfile> /V" or run the        #
cmd.exe /c echo #           verbose_event_query script               #
cmd.exe /c echo ######################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                DRIVE INFORMATION               #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 


cmd.exe /c fsutil fsinfo drives
cmd.exe /c echo.

echo Free Disk Space on C:
cmd.exe /c fsutil volume diskfree c:
cmd.exe /c echo.

pause; 
echo Free Disk Space on D:
cmd.exe /c fsutil volume diskfree d:
cmd.exe /c echo.

pause; 
echo Free Disk Space on E:
cmd.exe /c fsutil volume diskfree e:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS C:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c vol c:
cmd.exe /c fsutil fsinfo drivetype c:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS D:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c vol d:
cmd.exe /c fsutil fsinfo drivetype d:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS E:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c vol e:
cmd.exe /c fsutil fsinfo drivetype e:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo # If there are any more drives run fsutil again  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #     Further querying DRIVE INFORMATION         #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c echo list disk > %systemroot%\driveinfo.txt
cmd.exe /c echo list volume > %systemroot%\driveinfo.txt

cmd.exe /c diskpart /s %systemroot%\driveinfo.txt

cmd.exe /c del %systemroot%\driveinfo.txt

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #               SYSTEM INFORMATION               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

cmd.exe /c systeminfo

pause; 

reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING SOFTWARE KEY               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

reg query "HKLM\Software" 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #       CHECKING CURRENTVERSION INFO KEY         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

reg query "HKLM\software\Microsoft\Windows NT\CurrentVersion"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #             CHECKING WINLOGON KEY              #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\software\microsoft\windows NT\currentversion\winlogon"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #       VALUE IN LOCAL MACHINE RUN KEY           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN LOCAL MACHINE RUNONCE KEY        #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN LOCAL MACHINE WINDOWS KEY        #
cmd.exe /c echo #       LOOKING FOR APPINIT_DLL PRESENCE         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Windows"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN CURRENT USER RUN KEY             #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN CURRENT USER RUNONCE KEY         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #       Checking TCPIP Network Configs           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\SYSTEM\ControlSet001\Services\Tcpip\Parameters\Interfaces" /s

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #       Checking for Wireless Networks           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\SOFTWARE\Microsoft\WZCSVC\Parameters\Interfaces"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #     IF USING WEP, KEY WILL BE STORED HERE      #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKCU\SOFTWARE\Microsoft\WZCSVC\Parameters\Interfaces"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          Checking for LAN Computers            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\ComputerDescriptions"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING FOR COMPUTER NAME            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           CHECKING IE INFORMATION              #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Internet Explorer"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING USER'S IE START PAGE         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Internet Explorer\Main" | find "Start Page"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING USER'S IE TYPED URL's        #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;  

reg query "HKCU\Software\Microsoft\Internet Explorer\TypedURLs"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING PRINTER INFORMATION          #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

cmd.exe /c cscript %systemroot%\system32\prnjobs.vbs -l
cmd.exe /c cscript %systemroot%\system32\prncnfg.vbs -g

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING FW CONFIGRUATIONS            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

cmd.exe /c netsh firewall show config

pause; 

cmd.exe /c netsh firewall show opmode

pause; 

reg query "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\AuthorizedApplications\List"

pause; 

reg query "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\AuthorizedApplications\List"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #              PERFORMING CLEANUP                #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

cmd.exe /c del %systemroot%\prefetch\arp.exe*
cmd.exe /c del %systemroot%\prefetch\cmd.exe*
cmd.exe /c del %systemroot%\prefetch\CSCRIPT.EXE*
cmd.exe /c del %systemroot%\prefetch\DISKPART.EXE*
cmd.exe /c del %systemroot%\prefetch\DMADMIN.EXE*
cmd.exe /c del %systemroot%\prefetch\FIND.EXE*
cmd.exe /c del %systemroot%\prefetch\FSUTIL.EXE*
cmd.exe /c del %systemroot%\prefetch\IPCONFIG.EXE*
cmd.exe /c del %systemroot%\prefetch\MODE.COM*
cmd.exe /c del %systemroot%\prefetch\MORE.COM*
cmd.exe /c del %systemroot%\prefetch\NET.EXE*
cmd.exe /c del %systemroot%\prefetch\NET1.EXE*
cmd.exe /c del %systemroot%\prefetch\NETSH.EXE*
cmd.exe /c del %systemroot%\prefetch\NETSTAT.EXE*
cmd.exe /c del %systemroot%\prefetch\REG.EXE*
cmd.exe /c del %systemroot%\prefetch\ROUTE.EXE*
cmd.exe /c del %systemroot%\prefetch\SYSTEMINFO.EXE*
cmd.exe /c del %systemroot%\prefetch\TASKLIST.EXE*
cmd.exe /c del %systemroot%\prefetch\WMIPRVSE.EXE*

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING SCHEDULED TASKS            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause; 
cmd.exe /c dir %SYSTEMROOT%\tasks

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING PREFETCH DIRECTORY         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause; 

cmd.exe /c dir %SYSTEMROOT%\prefetch

pause;

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING "AT" JOBS                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

cmd.exe /c at

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            SCRIPT COMPLETE                     #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

goto exit

:ver_post-vista
:Run Windows NT specific commands here.
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #        PROCESS LIST WITH CPU TIME STATS        #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 
rem cmd.exe /c %cd%\pslist.exe /accepteula
rem get-process | Format-Table -AutoSize -Property Id,processname,description,startttime
cmd.exe /c powershell get-process | more

pause; 
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo # PROCESS LIST WITH FULL PATH, TYPE Q TO MOVE ON #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c powershell get-process -fileversioninfo | more

pause; 
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           CONFIRMING LAST BOOT TIME            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c systeminfo | find "System Boot Time"
cmd.exe /c echo.

pause; 
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                CHECKING USER                   #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause;

cmd.exe /c echo %USERDOMAIN%\%USERNAME%
cmd.exe /c echo %WINDIR%

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                  OS CHECK                      #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

cmd.exe /c "echo >OSVer.vbs Set OSSet = GetObject("winmgmts:{impersonationLevel=impersonate}!//./root/cimv2").ExecQuery("select caption, CSDVersion, SerialNumber from Win32_OperatingSystem")"

cmd.exe /c "echo >>OSVer.vbs For Each OS In OSSet"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Operating System=" ^& OS.Caption"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Service Pack=" ^& OS.CSDVersion"

cmd.exe /c "echo >>OSVer.vbs wscript.echo "Product ID=" ^& OS.SerialNumber"

cmd.exe /c "echo >>OSVer.vbs Next"

cmd.exe /c "cscript //nologo OSVer.vbs"

cmd.exe /c del OSVer.vbs

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            32 OR 64-BIT CHECK                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

Set RegQry=HKLM\Hardware\Description\System\CentralProcessor\0
 
REG.exe Query %RegQry% > checkOS.txt
 
Find /i "x86" < CheckOS.txt > StringCheck.txt
 
If %ERRORLEVEL% == 0 (
    Echo "This is a 32-bit Operating system"
) ELSE (
    Echo "This is a 64-bit Operating System"
)

cmd.exe /c del StringCheck.txt
cmd.exe /c del checkOS.txt

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #         CURRENT WORKING DIRECTORY              #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c chdir
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #              RETRIEVING OS CULTURE             #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c powershell get-culture

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #              TARGET DATE\TIME                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c echo The DATE is: %date%
cmd.exe /c echo The TIME is: %time%
cmd.exe /c powershell get-date
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #               TARGET OS INFORMATION            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c systeminfo | find "Host Name"
cmd.exe /c systeminfo | find "OS Name"
cmd.exe /c systeminfo | find "OS Version"
cmd.exe /c systeminfo | find "OS Configuration"
cmd.exe /c systeminfo | find "Logon Server"
cmd.exe /c systeminfo | find "Original Install Date"
cmd.exe /c systeminfo | find "Product ID"
cmd.exe /c systeminfo | find "Registered Owner"
cmd.exe /c systeminfo | find "Registered Organization"
cmd.exe /c systeminfo | find "Domain"
cmd.exe /c systeminfo | find "Network Card(s)"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            TARGET PLATFORM INFORMATION         #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

cmd.exe /c systeminfo | find "System Manufacturer"
cmd.exe /c systeminfo | find "System Model"
cmd.exe /c systeminfo | find "System Type"
cmd.exe /c systeminfo | find "Processor(s)"
pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #   NOW CHECKING NETWORK INTERFACE INFORMATION   #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c ipconfig /all | more
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      CHECKING COMPUTER'S PUBLIC IP ADDRESS     #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause;

rem wget -q -O - http://www.showmyip.com/simple/

cmd.exe /c echo var request = new ActiveXObject("Msxml2.XMLHTTP"); > ext_ip.js
cmd.exe /c echo var notyetready = 1; >> ext_ip.js

cmd.exe /c echo request.onreadystatechange=function() >> ext_ip.js 
cmd.exe /c echo { >> ext_ip.js
cmd.exe /c echo if(request.readyState==4) >> ext_ip.js
cmd.exe /c echo { >> ext_ip.js
cmd.exe /c echo WScript.Echo(request.responseText); >> ext_ip.js 
cmd.exe /c echo notyetready = 0; >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js
cmd.exe /c echo. >> ext_ip.js
cmd.exe /c echo request.open( "GET", "http://www.whatismyip.com/automation/n09230945.asp", true ); >> ext_ip.js 
cmd.exe /c echo request.send(null); >> ext_ip.js 
cmd.exe /c echo. >> ext_ip.js
cmd.exe /c echo while( notyetready ) >> ext_ip.js 
cmd.exe /c echo { >> ext_ip.js 
cmd.exe /c echo WScript.Sleep( 100 ); >> ext_ip.js 
cmd.exe /c echo } >> ext_ip.js 

cmd.exe /c cscript ext_ip.js

cmd.exe /c del ext_ip.js

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW CHECKING NETWORK CONNECTION INFO      #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c netstat -an | more
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW CHECKING NETWORK ROUTING INFO         #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c route print | more
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            NOW CHECKING ARP INFO               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

cmd.exe /c arp -a 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY NETWORK SHARES                #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
cmd.exe /c net share
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY LOCAL USER ACCOUNTS           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;
cmd.exe /c net user
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY LOCAL GROUPS                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;
cmd.exe /c net localgroup
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #   NOW DISPLAY USERS BELONGING TO ADMIN GROUP   #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;
cmd.exe /c net localgroup administrators
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY COMPUTERS IN MY WORKGROUP     #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;
cmd.exe /c net view
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      NOW DISPLAY DOMAIN INFO                   #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;
cmd.exe /c net view /domain

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #             Checking Eventlogs                 #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c powershell get-eventlog system -newest 100
pause; 
cmd.exe /c powershell get-eventlog application -newest 100
pause; 
cmd.exe /c powershell get-eventlog security -newest 100
pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #                DRIVE INFORMATION               #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c powershell get-psdrive
pause; 

cmd.exe /c fsutil fsinfo drives
cmd.exe /c echo.

pause; 
echo Free Disk Space on C:
cmd.exe /c fsutil volume diskfree c:
cmd.exe /c echo.

pause; 
echo Free Disk Space on D:
cmd.exe /c fsutil volume diskfree d:
cmd.exe /c echo.

pause; 
echo Free Disk Space on E:
cmd.exe /c fsutil volume diskfree e:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS C:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 
cmd.exe /c vol c:
cmd.exe /c fsutil fsinfo drivetype c:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS D:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c vol d:
cmd.exe /c fsutil fsinfo drivetype d:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           WHAT TYPE OF DRIVE IS E:?            #
cmd.exe /c echo ##################################################
cmd.exe /c echo. 

pause; 

cmd.exe /c vol e:
cmd.exe /c fsutil fsinfo drivetype e:
cmd.exe /c echo.

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo # IF THERE ARE ANY MORE DRIVES RUN FSUTIL AGAIN  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #               SYSTEM INFORMATION               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING SOFTWARE KEY               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

reg query "HKLM\Software" 
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #       VALUE IN LOCAL MACHINE RUN KEY           #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Run"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN LOCAL MACHINE RUNONCE KEY        #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Runonce"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN CURRENT USER RUN KEY             #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Run"

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #      VALUE IN CURRENT USER RUNONCE KEY         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #           NETWORKS IN NETWORK LIST PROFILES    #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Profiles" /s
cmd.exe /c echo.
cmd.exe /c echo ############################################################
cmd.exe /c echo #  LISTING THE DEFAULT GATEWAY MAC FOR NET PROFILES        #
cmd.exe /c echo ############################################################
cmd.exe /c echo.

pause;
reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\Unmanaged" /s

cmd.exe /c echo.
cmd.exe /c echo ############################################################
cmd.exe /c echo #     VIEW AVAILABLE WIRELESS NETWORKS IN THE AREA         #
cmd.exe /c echo ############################################################
cmd.exe /c echo.

pause;
cmd.exe /c netsh wlan show all

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING FOR COMPUTER NAME            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

reg query "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING IE INFORMATION               #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

reg query "HKCU\Software\Microsoft\Internet Explorer"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING USER'S IE START PAGE         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

reg query "HKCU\Software\Microsoft\Internet Explorer\Main" /v "Start Page" /t REG_SZ
cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING USER'S IE TYPED URL's        #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

reg query "HKCU\Software\Microsoft\Internet Explorer\TypedURLs"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #          CHECKING FW CONFIGRUATIONS            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause; 
cmd.exe /c netsh firewall show opmode
pause; 
cmd.exe /c netsh advfirewall show allprofiles
pause; 

reg query "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\AuthorizedApplications\List"

reg query "HKLM\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile\Logging"

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #              PERFORMING CLEANUP                #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 

cmd.exe /c del %systemroot%\prefetch\AgGlFaultHistory.db*
cmd.exe /c del %systemroot%\prefetch\AgGlFgAppHistory.db*
cmd.exe /c del %systemroot%\prefetch\AgGlGlobalHistory.db*
cmd.exe /c del %systemroot%\prefetch\AgRobust.db*
cmd.exe /c del %systemroot%\prefetch\ARP.EXE*
cmd.exe /c del %systemroot%\prefetch\AUDIODG.EXE*
cmd.exe /c del %systemroot%\prefetch\CMD.EXE*
cmd.exe /c del %systemroot%\prefetch\CONHOST.EXE*
cmd.exe /c del %systemroot%\prefetch\CSCRIPT.EXE*
cmd.exe /c del %systemroot%\prefetch\DLLHOST.EXE*
cmd.exe /c del %systemroot%\prefetch\DLLHOST.EXE*
cmd.exe /c del %systemroot%\prefetch\DOSKEY.EXE*
cmd.exe /c del %systemroot%\prefetch\FIND.EXE*
cmd.exe /c del %systemroot%\prefetch\FSUTIL.EXE*
cmd.exe /c del %systemroot%\prefetch\IPCONFIG.EXE*
cmd.exe /c del %systemroot%\prefetch\MODE.COM*
cmd.exe /c del %systemroot%\prefetch\MORE.COM*
cmd.exe /c del %systemroot%\prefetch\NET.EXE*
cmd.exe /c del %systemroot%\prefetch\NET1.EXE*
cmd.exe /c del %systemroot%\prefetch\NETSH.EXE*
cmd.exe /c del %systemroot%\prefetch\NETSTAT.EXE*
cmd.exe /c del %systemroot%\prefetch\NOTEPAD.EXE*
cmd.exe /c del %systemroot%\prefetch\POSTGRES.EXE*
cmd.exe /c del %systemroot%\prefetch\POSTGRES.EXE*
cmd.exe /c del %systemroot%\prefetch\POWERSHELL.EXE*
cmd.exe /c del %systemroot%\prefetch\REG.EXE*
cmd.exe /c del %systemroot%\prefetch\ROUTE.EXE*
cmd.exe /c del %systemroot%\prefetch\SEARCHFILTERHOST.EXE*
cmd.exe /c del %systemroot%\prefetch\SEARCHPROTOCOLHOST.EXE*
cmd.exe /c del %systemroot%\prefetch\SYSTEMINFO.EXE*
cmd.exe /c del %systemroot%\prefetch\TASKLIST.EXE*
cmd.exe /c del %systemroot%\prefetch\TRUSTEDINSTALLER.EXE*
cmd.exe /c del %systemroot%\prefetch\WMIPRVSE.EXE*

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING SCHEDULED TASKS            #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause; 
cmd.exe /c dir %SYSTEMROOT%\tasks

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING PREFETCH DIRECTORY         #
cmd.exe /c echo ##################################################
cmd.exe /c echo.
pause; 

cmd.exe /c dir %SYSTEMROOT%\prefetch

pause;

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            CHECKING "AT" JOBS                  #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

cmd.exe /c at

pause; 

cmd.exe /c echo.
cmd.exe /c echo ##################################################
cmd.exe /c echo #            SCRIPT COMPLETE                     #
cmd.exe /c echo ##################################################
cmd.exe /c echo.

pause;

goto exit

:warnthenexit
echo Machine undetermined.

