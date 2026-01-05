$duration = [int](Read-Host "Specify duration (in minutes)")
$pollingRate = [int](Read-Host "Specify polling rate (1-10 seconds)")
$endTime = (Get-Date).AddMinutes($duration)

Write-Host "`nMonitoring audio devices for $duration minutes..." -ForegroundColor Yellow

# Initial snapshot
$lastDevices = (Get-CimInstance Win32_SoundDevice).Name

while ((Get-Date) -lt $endTime) {
    try {
        $currentDevices = (Get-CimInstance Win32_SoundDevice).Name

        # Detect removed devices
        $lost = $lastDevices | Where-Object { $_ -notin $currentDevices }

        # Detect new devices
        $added = $currentDevices | Where-Object { $_ -notin $lastDevices }

        if ($lost.Count -gt 0) {
            Write-Host "$(Get-Date): AUDIO DEVICE DISCONNECTED!" -BackgroundColor Red
            $lost | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
            [console]::Beep(300, 200)
            [console]::Beep(200, 200)
        }

        if ($added.Count -gt 0) {
            Write-Host "$(Get-Date): New audio device detected." -ForegroundColor Green
            $added | ForEach-Object { Write-Host " + $_" -ForegroundColor Green }
            [console]::Beep(900, 150)
            [console]::Beep(1100, 150)
        }

        # Update snapshot
        $lastDevices = $currentDevices

    } catch {
        Write-Host "$(Get-Date): Unable to retrieve audio device list." -ForegroundColor Red
    }

    Start-Sleep -Seconds $pollingRate
}

Write-Host "`nMonitoring complete." -ForegroundColor Green
[console]::Beep(700, 50)
[console]::Beep(700, 50)
