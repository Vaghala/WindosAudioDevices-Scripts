[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null;[Windows.UI.Notifications.ToastNotificationManager]::History.Clear('NotifyIconGeneratedAumid_13598117018880673923')
$Speakers = 'DELL G3223D';
$Headphones = 'Headphones';
$Active = &  D:\Downloads\ToolsNScripts\GetDefautAudio.exe;

if($Active -eq $Headphones){
    D:\Downloads\ToolsNScripts\nircmd.exe setdefaultsounddevice $Speakers 1;
    D:\Downloads\ToolsNScripts\nircmd.exe setdefaultsounddevice $Speakers 2;
    D:\Downloads\ToolsNScripts\nircmd.exe trayballoon "Default Sound Device Changed" $Speakers.ToString() "ddores.dll,1" 10000
    D:\Downloads\ToolsNScripts\nircmd.exe stdbeep
    }else{
    D:\Downloads\ToolsNScripts\nircmd.exe setdefaultsounddevice $Headphones 1;
    D:\Downloads\ToolsNScripts\nircmd.exe setdefaultsounddevice $Headphones 2;
    D:\Downloads\ToolsNScripts\nircmd.exe trayballoon "Default Sound Device Changed" $Headphones.ToString() "ddores.dll,2" 10000
    D:\Downloads\ToolsNScripts\nircmd.exe stdbeep
}
sleep 0.6
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null;[Windows.UI.Notifications.ToastNotificationManager]::History.Clear('NotifyIconGeneratedAumid_13598117018880673923')
# One Line
# $Speakers = 'DELL G3223D'; $Headphones = 'Headphones'; $Active = & .\GetDefautAudio.exe;if($Active -eq $Headphones){.\nircmd.exe setdefaultsounddevice $Speakers 1;.\nircmd.exe setdefaultsounddevice $Speakers 2;}else{.\nircmd.exe setdefaultsounddevice $Headphones 1;.\nircmd.exe setdefaultsounddevice $Headphones 2;}

#close tile
#[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null;[Windows.UI.Notifications.ToastNotificationManager]::History.Clear('NotifyIconGeneratedAumid_13598117018880673923')

<#
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null

$notifications = Get-ChildItem -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings' | Select-Object -ExpandProperty Name

foreach ($notification in $notifications) { 
    $lastRegistryKeyName = ($notification -split '\\')[-1] -replace '\\$'
    echo $lastRegistryKeyName
    [Windows.UI.Notifications.ToastNotificationManager]::History.Clear($lastRegistryKeyName) 
}

#>