Add-Type -AssemblyName System.Windows.Forms

$selection = Read-Host @"
1) Monitor all connected displays
2) Monitor specific display by name
`nNOTE: Connected displays must be powered on and active!
"@

if ($selection -eq "1") {
    $duration = [int](Read-Host "Please specify a duration (in minutes)")
    $pollingRate = [int](Read-Host "Please specify a polling rate (1-10 seconds)")
    $endTime = (Get-Date).AddMinutes($duration)

    $initialScreens = [System.Windows.Forms.Screen]::AllScreens
    $initialDevices = Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -like "*Monitor*" }

    Write-Host "`nMonitoring all HDMI displays for $duration minutes..." -ForegroundColor Yellow

    while ((Get-Date) -lt $endTime) {
        $currentScreens = [System.Windows.Forms.Screen]::AllScreens
        $currentDevices = Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -like "*Monitor*" }

        foreach ($device in $initialDevices) {
            if (-not ($currentDevices.DeviceID -contains $device.DeviceID)) {
                Write-Host "$(Get-Date): Display '$($device.Name)' disconnected!" -BackgroundColor Red
                [console]::beep(400, 100)
            }
        }

        Start-Sleep -Seconds $pollingRate
    }

    Write-Host "`nMonitoring complete." -ForegroundColor Green
    [console]::beep(700, 50)
    [console]::beep(700, 50)
}
elseif ($selection -eq "2") {
    $targetName = Read-Host "Enter part of the display name to monitor (e.g., 'Generic' or 'Dell')"
    $duration = [int](Read-Host "Please specify a duration (in minutes)")
    $pollingRate = [int](Read-Host "Please specify a polling rate (1-10 seconds)")
    $endTime = (Get-Date).AddMinutes($duration)

    Write-Host "`nMonitoring display containing '$targetName' for $duration minutes..." -ForegroundColor Yellow

    while ((Get-Date) -lt $endTime) {
        $device = Get-CimInstance Win32_PnPEntity | Where-Object { $_.Name -like "*$targetName*" }

        if ($device) {
            Write-Host "$(Get-Date): Display '$($device.Name)' is connected."
            [console]::beep(500, 100)
        } else {
            Write-Host "$(Get-Date): Display '$targetName' is disconnected!" -BackgroundColor Red
            [console]::beep(400, 100)
        }

        Start-Sleep -Seconds $pollingRate
    }

    Write-Host "`nMonitoring complete." -ForegroundColor Green
    [console]::beep(700, 50)
    [console]::beep(700, 50)
}
else {
    Write-Host "Invalid selection. Please choose 1 or 2." -ForegroundColor Red
}
