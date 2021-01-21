<#
.SYNOPSIS
    Veeam-FileCopyJob-Retention-Check.ps1 - PowerShell Script to apply a retention on copied Files with Veeam File Copy Jobs.
.DESCRIPTION
    This script is mainly used in scenarios where Veeam Configuration Backups are being copied to other servers with the built in Veeam File Copy Job.
    Unfortunately Veeam does not offer (for now) any kind of retention within File Copy Jobs.
.OUTPUTS
    Results are printed to the console.
.NOTES
    Author        Falko Banaszak, https://virtualhome.blog, Twitter: @Falko_Banaszak
    
    Change Log    V1.00, 21/01/2021 - Initial version: Works on Windows Servers only 

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
# Feel free to adjust the 30 days with a value of your choice
$DaysToDelete = "-30"
# Place the path where your Veeam Config Backups are located here
$WorkingPath = "C:\VeeamConfigBackup"
# Place the servername where the remote Veeam Config Backup files are located here
$Server = "servername.fq.dn"
# Get the current date
$CurrentDate = Get-Date
# Make the Delete Days variable which gets used to determine the age of the files
$DeleteDays = $CurrentDate.AddDays($DaysToDelete)
# Check if written Veeam Configuration Backup files (.bco files) are older than 30 days and delete them
Invoke-Command -ComputerName $Server {Get-ChildItem $WorkingPath -Filter ".bco"| Where-Object { $_.LastWriteTime -lt $DeleteDays } | Remove-Item}