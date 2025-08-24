$duration = [int](Read-Host "Specify duration (in minutes)")
$pollingRate = [int](Read-Host "Specify polling rate (1-10 seconds)")
$endTime = (Get-Date).AddMinutes($duration)

Write-Host "`nMonitoring power connection for $duration minutes..." -ForegroundColor Yellow

while ((Get-Date) -lt $endTime) {
    try {
        $powerStatus = Get-WmiObject -Class BatteryStatus -Namespace root\wmi
        $onPower = $false

        foreach ($status in $powerStatus) {
            if ($status.PowerOnline -eq $true) {
                $onPower = $true
            }
        }

        if ($onPower -eq $true) {
            Write-Host "$(Get-Date): System is on AC power." -ForegroundColor Green
        } else {
            Write-Host "$(Get-Date): System is running on battery!" -BackgroundColor Red
            [console]::beep(400, 100)
        }
    } catch {
        Write-Host "$(Get-Date): Unable to retrieve power status." -ForegroundColor Red
    }

    Start-Sleep -Seconds $pollingRate
}

Write-Host "`nMonitoring complete." -ForegroundColor Green
[console]::beep(700, 50)
[console]::beep(700, 50)
