Get-ChildItem C:\Users\kyles\Downloads\* | Remove-Item -recurse -force
Clear-RecycleBin
Write-Host " "
Write-Host "Downloads and Recycle Bin Cleared"
Write-Host " "

$HistChoice = Read-Host -Prompt "Would you also like to clear your Chrome browsing data? This will stop Chrome if it is currently running.Y/N?"

if ($HistChoice -eq 'Y') {
    taskkill /F /IM "chrome.exe" /fi "memusage gt 2"
    Start-Sleep -Seconds 1
    $Items = @('Archived History',
                'Cache\*',
                'Cookies',
                'History',
                'Login Data',
                'Top Sites',
                'Visited Links',
                'Web Data')
    $Folder = "$($env:LOCALAPPDATA)\Google\Chrome\User Data\Default"
    $Items | % { 
        if (Test-Path "$Folder\$_") {
            Remove-Item "$Folder\$_" -Recurse
        }
    }
    Write-Host "Chrome Data Cleared"
}


Write-Host CLEAN!

pause
