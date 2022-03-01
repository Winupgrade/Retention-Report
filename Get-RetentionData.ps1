<#PSScriptInfo

.VERSION 1.0

.GUID 7ae81886-5392-45a9-8ccf-46153917240d

.AUTHOR Jack Terry

.COMPANYNAME Winupgrade Limited

.COPYRIGHT Winupgrade Limited

.TAGS 

.LICENSEURI 

.PROJECTURI https://github.com/winupgrade/retention-report

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES

#> 

#Requires -Module ExchangeOnlineManagement
#Requires -Module Microsoft.Online.SharePoint.PowerShell

<# 

.DESCRIPTION Run this script to export the metadata required to refresh the Power BI Office 365 Retention Report... 

#> 
Param()

Write-Host "This script will export your Office 365 retention metadata to c:\Retention Report\ and overwrite any exsiting files..."
Pause

#Make working directory...
New-Item -Path "c:\" -Name "Retention Report" -ItemType "directory" -Force

#Connect to Compliance Center...
Write-Host "Please enter the credentials of an account with the Global Reader role assigned and activated..."
Connect-IPPSSession

#Pull and export retention policies...
$Policies=Get-RetentionCompliancePolicy -DistributionDetail
$Policies|?{$_.DistributionStatus-ne"Success"}|Export-csv -Path "c:\Retention Report\Policies.csv" -Force -NoTypeInformation
$Policies.ExchangeLocation|Select-Object -Property Name|Sort-Object -Property Name -Unique|Export-Csv -Path "c:\Retention Report\ExchangeLocation.csv" -Force -NoTypeInformation
$Policies.OneDriveLocation|Select-Object -Property Name|Sort-Object -Property Name -Unique|Export-Csv -Path "c:\Retention Report\OneDriveLocation.csv" -Force -NoTypeInformation
$Policies.SharePointLocation|Select-Object -Property Name|Sort-Object -Property Name -Unique|Export-Csv -Path "c:\Retention Report\SharePointLocation.csv" -Force -NoTypeInformation
$Policies.ModernGroupLocation|Select-Object -Property Name|Sort-Object -Property Name -Unique|Export-Csv -Path "c:\Retention Report\GroupsLocation.csv" -Force -NoTypeInformation

#Connect to Exchange Admin Center...
Write-Host "Please enter the credentials of an account with the Global Reader role assigned and activated..."
Connect-ExchangeOnline

#Pull and export mailbox and groups metadata...
Get-EXOMailbox -ResultSize Unlimited -Filter "RecipientTypeDetails -eq 'UserMailbox' -or RecipientTypeDetails -eq 'SharedMailbox'"|Select-Object -Property PrimarySmtpAddress|Export-Csv -Path "c:\Retention Report\Mailboxes.csv" -Force -NoTypeInformation
Get-UnifiedGroup -ResultSize Unlimited|Select-Object -Property PrimarySmtpAddress|Export-Csv -Path "c:\Retention Report\Groups.csv" -Force -NoTypeInformation

#Connect to Sharepoint Admin Center...
Write-Host "Please enter the URL of your SharePoint Admin Center E.g. https://[yourtenantname]-admin.sharepoint.com..."
Write-Host "Please enter the credentials of an account with the Global Reader role assigned and activated..."
Connect-SPOService

#Pull and export OneDrive and SharePoint metadata...
Get-SPOSite -Limit All -IncludePersonalSite $True|?{$_.Url-like"*-my.sharepoint.com/personal/*"}|Select-Object -Property Url|Export-Csv -Path "c:\Retention Report\Profiles.csv" -Force -NoTypeInformation
Get-SPOSite -Limit All|Select-Object -Property Url|Export-Csv -Path "c:\Retention Report\Sites.csv" -Force -NoTypeInformation

#Contact: info@winupgrade.co.uk
Write-Host "`nContact: info@winupgrade.co.uk`n"
Pause