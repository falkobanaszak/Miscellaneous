<#
.SYNOPSIS
    Backup-Windows-PrintServer-Script.ps1 - PowerShell Script to backup Windows Print Server configuration to a single file
.DESCRIPTION
    This script is used to backup a Windows Server print server configuration to a single file.
    You can run this script on the windows server itself before a backup starts for this Windows server.
.OUTPUTS
    - Results are printed to the console.
    - An event log entry is created for every backup session with printbrm.exe
    - To backup the Windows server printing configuration, printbrm.exe is used
      (https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134237(v=ws.11)

.NOTES
    Author        Falko Banaszak, https://virtualhome.blog, Twitter: @Falko_Banaszak
    
    Change Log    V1.00, 26/01/2021 - Initial version: Works on Windows Server 2012 to Windows Server 2019 

.LICENSE
    MIT License
    Copyright (c) 2019 Falko Banaszak
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
#>
# Declare your backup path here
$FileName = "C:\Path\PrintServerBackupFiles\${env:computername}_$(get-date -f dd-MM-yyyy-hhmm).printerexport"
$BackupPath = "C:\Path\PrintServerBackupFiles"
$LogPath = "C:\Path\PrintServerBackupLogFiles"

# Create new eventlog source
New-EventLog -LogName System -Source "Print Server Config Backup Script"

# Create new eventlog entry
Write-EventLog -LogName System -Source "Print Server Config Backup Script" -EntryType Information -EventId 1 -Message "Print Server Backup Script: Backup Script started"

# Backup Windows Server Print Configuration to given $BackupPath and log everything to given $LogPath
c:\windows\system32\spool\tools\PrintBrm.exe -B -F $BackupPath\${env:computername}_$(get-date -f dd-MM-yyyy-hhmm).printerexport | out-file -filepath $LogPath\${env:computername}_$(get-date -f dd-MM-yyyy-hhmm).log

# Erstelle Eventlog Eintrag
Write-EventLog -LogName System -Source "Print Server Config Backup Script" -EntryType Information -EventId 1 -Message "Print Server Backup Script: Backup Script ended successfully"

# Lösche alte Backupfiles
get-childitem C:\printserverexport\backupfiles\ -Recurse| where{-not $_.PsIsContainer} | sort CreationTime -desc | select -Skip 5 | Remove-Item -Force

# Erstelle Eventlog Eintrag
Write-EventLog -LogName System -Source "kohn.blog" -EntryType Information -EventId 1 -Message "Verzeichnis C:\Printserverexport\logs\ aufgeräumt, alte Backup-Logs entfernt, es werden nur die aktuellsten 5 Backup-Logs aufgehoben, PKohn_printserver_backup_script"

# Lösche alte Backuplogs
get-childitem C:\printserverexport\logs\ -Recurse| where{-not $_.PsIsContainer} | sort CreationTime -desc | select -Skip 5 | Remove-Item -Force

try{
    $BackupPath = "C:\Path\Files"
    command.exe -Out-File $FilePath\${env:computername}_$(get-date -f dd-MM-yyyy-hhmm).file
           
    --write below successfull log entry
    you also could add more checks like below
     if (test-path "$FilePath\${env:computername}_$(get-date -f dd-MM-yyyy-hhmm)"){
    write here successfull log entry
    }
    else
    {
     ---write here unsuccessfull log entry
    }     
    catch{
    ---write here unsuccessfull log entry
    }