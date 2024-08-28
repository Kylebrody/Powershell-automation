Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Windows.Forms.Application]::EnableVisualStyles()

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(650,300)
$form.StartPosition = 'CenterScreen'


$clearDownloads = New-Object System.Windows.Forms.Button
$clearDownloads.Size = New-Object System.Drawing.Size(300,23)
$clearDownloads.Text = 'Clear Downloads/Recycle Bin'
$form.Controls.Add($clearDownloads)

$clearChrome = New-Object System.Windows.Forms.Button
$clearChrome.Location = New-Object System.Drawing.Point(0.5,25)
$clearChrome.Size = New-Object System.Drawing.Size(300,23)
$clearChrome.Text = 'Clear Chrome History and Cache'
$form.Controls.Add($clearChrome)


$clearDownloads.Add_Click(

{

Get-ChildItem C:\Users\kyles\Downloads\* | Remove-Item -recurse -force
Clear-RecycleBin

}

)

$clearChrome.Add_Click(

{

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

}

)


$form.Topmost = $true

$form.Add_Shown({$form.Activate()})

$form.ShowDialog()

