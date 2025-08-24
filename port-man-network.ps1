$duration = [int](Read-Host "Specify duration (in minutes)")
$pollingRate = [int](Read-Host "Specify polling rate (1-10 seconds)")
$endTime = (Get-Date).AddMinutes($duration)

# Get initial list of Ethernet adapters
$initialAdapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.InterfaceDescription -like "*Ethernet*" }

Write-Host "`nMonitoring Ethernet adapters for $duration minutes..." -ForegroundColor Yellow

while ((Get-Date) -lt $endTime) {
    $currentAdapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" -and $_.InterfaceDescription -like "*Ethernet*" }

    foreach ($adapter in $initialAdapters) {
        if (-not ($currentAdapters.Name -contains $adapter.Name)) {
            Write-Host "$(Get-Date): Ethernet adapter '$($adapter.Name)' is DOWN or disconnected!" -BackgroundColor Red
            [console]::beep(400, 100)
        }
    }

    Start-Sleep -Seconds $pollingRate
}

Write-Host "`nMonitoring complete." -ForegroundColor Green
[console]::beep(700, 50)
[console]::beep(700, 50)
