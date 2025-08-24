$selection = Read-Host @"
1) Test all USB ports
2) Test specific USB port
`nNOTE: You must have all USB ports occupied with a device for this to work!
"@

if ($selection -eq "1") {
    $duration = [int](Read-Host "Please specify a duration (in minutes)")
    $pollingRate = [int](Read-Host "Please specify a polling rate (1-10 seconds)")
    $endTime = (Get-Date).AddMinutes($duration)

    # Get initial list of USB devices
    $initialDevices = Get-PnpDevice -Class USB | Where-Object { $_.Status -eq "OK" }

    Write-Host "`nMonitoring all USB devices for $duration minutes..." -ForegroundColor Yellow

    while ((Get-Date) -lt $endTime) {
        $currentDevices = Get-PnpDevice -Class USB | Where-Object { $_.Status -eq "OK" }

        foreach ($device in $initialDevices) {
            if (-not ($currentDevices.DeviceID -contains $device.DeviceID)) {
                Write-Host "$(Get-Date): Device '$($device.FriendlyName)' disconnected!" -BackgroundColor Red
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
    $targetName = Read-Host "Enter part of the device name to monitor (e.g., 'Mouse' or 'Storage')"
    $duration = [int](Read-Host "Please specify a duration (in minutes)")
    $pollingRate = [int](Read-Host "Please specify a polling rate (1-10 seconds)")
    $endTime = (Get-Date).AddMinutes($duration)

    Write-Host "`nMonitoring device containing '$targetName' for $duration minutes..." -ForegroundColor Yellow

    while ((Get-Date) -lt $endTime) {
        $device = Get-PnpDevice -Class USB | Where-Object { $_.FriendlyName -like "*$targetName*" }

        if ($device) {
            Write-Host "$(Get-Date): Device '$($device.FriendlyName)' is connected."
            [console]::beep(500, 100)
        } else {
            Write-Host "$(Get-Date): Device '$targetName' is disconnected!" -BackgroundColor Red
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
