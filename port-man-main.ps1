Write-Output @"                              
 _____         _                 
|  _  |___ ___| |_ _____ ___ ___ 
|   __| . |  _|  _|     | .'|   |
|__|  |___|_| |_| |_|_|_|__,|_|_|
"@ 

Write-Output @"
---------------------------------
1) Run USB Port Test
2) Run Video Port Test
3) Run Audio Port Test - Coming Soon!
4) Run Networking Port Test
5) AC Port Test 
6) Help & Additional Information (READ)`n
"@

$selection = Read-Host "Select and option and press ENTER"

if($selection -eq 1){
    & ".\port-man-usb"
}

elseif($selection -eq 2){
    & ".\port-man-video"
}

elseif($selection -eq 3){
    & ".\port-man-audio"
}

elseif($selection -eq 4){
    & ".\port-man-network"
}

elseif($selection -eq 5){
    & ".\port-man-power"
}

elseif ($selection -eq 6) {
    Write-Output @"
    `nPortman is a PowerShell tool designed for technicians to assess the effectiveness of various ports
on a given device. This is done by actively polling the ports on the device for a connection, and recording any
drops in connection. Such a tool can help technicians determine if a port is experiencing intermittent issues and
make informed decisions when determining if a replacement is needed.`n

The technician can specify how long and how many times per-minute the port should be polled. When the test has concluded,
the technician can see the results. Any port that has at least 10 or more disconnects should be considered for replacement.
                  
`nAs new features are released, more information will be provided here. NOTE: for the device to be successfully polled, it must
have some device connected to it. For example, if testing a USB port, please plug in a USB.  
"@
}