<#
 ____________________________________________
|                 WARNING                    |
|                                            |
| !!!! THIS SCRIPT IS NOT YET FINISHED !!!!  |
|                                            |
|                                            |
|____________________________________________|

.SYNOPSIS
    Get_Restore_Points.ps1 - PowerShell Script to gather all Veeam backup jobs and their restore points to display compression and dedup stats 
.DESCRIPTION
    This script is used to gather all Veeam backup jobs and their respective restore points
    The script checks display the compression and dedup stats in a .html file on a restore point basis
.OUTPUTS
    Results are printed to an .html file.
.NOTES
    Author        Falko Banaszak, https://virtualhome.blog, Twitter: @Falko_Banaszak
                  Matthias Mehrtens, Veeam Software, Solutions Architect
    
    Change Log    V1.00, 31/07/2020 - Initial version: Checks all Backup Jobs and theire respective restore points with dedup and compression stats
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
# Global Variables and Snapins
Add-PSSnapin VeeamPSSnapin
#$HTMLPath = "C:\temp"
#$HTMLName = "$HTMLPath\RestorePoints_$(Get-Date -Format dd_MM_yyyy_hh_mm_ss).html"

# Get all Veeam backup jobs
$BackupJobs = Get-VBRBackup

# Get all Veeam restore points of all the Veeam backup jobs
$RestorePoints = @()

foreach($BackupObject in $BackupJobs) {
    $BackupObjectRestorePoints = Get-VBRRestorePoint -Backup $BackupObject
    
    foreach($RP in $BackupObjectRestorePoints) {
        $RestorePoints += [PSCustomObject]@{
            VMName = $RP.VmName
            VMSize = $RP.ApproxSize
            BackupJob = $BackupObject.JobName
            CreationTime = $RP.CreationTime
            BackupType = $RP.algorithm
            BackupSize = $RP.GetStorage().stats.BackupSize
            DedupRatio = $RP.GetStorage().stats.DedupRatio
            ComprRatio = $RP.GetStorage().stats.CompressRatio
        }
    }
}

#$RestorePoints = $RestorePoints | Sort-Object -Property vmname, BackupJob, creationtime | ft
$RestorePoints | ConvertTo-Html -Property VMName,VMSize,BackupJob,CreationTIme,BackupType,BackupSize,DedupRatio,ComprRatio | Out-File -FilePath "C:\temp\RestorePoints_$(Get-Date -Format dd_MM_yyyy_hh_mm_ss).html"


#$RestorePoints | Export-Csv -Path $outfile -NoTypeInformation -Delimiter ';'
#$RestorePoints | Out-GridView