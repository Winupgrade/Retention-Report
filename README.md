# Office 365 Retention Report
A script to collect your Office 365 retention metadata and a Power BI report to visualise your tenant's retention status...

Office 365 retention policies can be a tricky subject! If you are unsure whether all your Office 365 data is protected by retention policies, please try running the following script and Power BI report for a graphical view of the retention status of your tenant.

**Prerequisites**

Exchange Online PowerShell V2 module
https://docs.microsoft.com/en-us/powershell/exchange/exchange-online-powershell-v2?view=exchange-ps

Sharepoint Online Management Shell
https://www.microsoft.com/en-gb/download/details.aspx?id=35588</p>

Microsoft Power BI Desktop
https://www.microsoft.com/en-us/download/details.aspx?id=58494

**PowerShell Script**

Run Get-RetentionData.ps1 to export all the retention metadata from your Office 365 tenant to 9 CSV files in C:\Retention Report\.

You will be asked for Office 365 Global Reader credentials twice to connect to the Compliance and Exchange Online Admin Centres, then you will be asked for your SharePoint Admin Centre URL (https://[yourtenantname]-admin.sharepoint.com) and your Global Reader credentials again to connect to the SharePoint Admin Centre.

**Power BI Report**

Open the Office 365 Retention Power BI report file to load your retention metadata into the report and explore the pages to see how protected your tenant is!
