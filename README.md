# Portman – Port Diagnostics Tool

![PowerShell](https://img.shields.io/badge/PowerShell-Tool-blue)
![License](https://img.shields.io/github/license/pryrotech/port-diagnostics-tool)
![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen)

**Portman** is a PowerShell-based utility designed for technicians to assess the reliability of various ports on a device. By actively polling connected ports and logging connection drops, Portman helps identify intermittent failures that may warrant hardware replacement.

## 🔧 Features

- 🕒 **Customizable Polling**: Set polling duration and frequency to suit your diagnostic needs  
- 📉 **Connection Drop Detection**: Automatically logs disconnect events for each port  
- 📊 **Clear Results Summary**: Highlights ports with frequent disconnects (≥10) for further inspection  
- 🔌 **Multi-Port Support**: Includes scripts for USB, audio, video, power, and network ports

## 📁 Included Scripts

| Script Name             | Purpose                          |
|------------------------|----------------------------------|
| `port-man-usb.ps1`     | Diagnose USB port reliability    |
| `port-man-audio.ps1`   | Monitor audio port connections   |
| `port-man-video.ps1`   | Check video port stability       |
| `port-man-power.ps1`   | Evaluate power port consistency  |
| `port-man-network.ps1` | Test network port connectivity   |
| `port-man-main.ps1`    | Main controller script           |

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/pryrotech/port-diagnostics-tool.git
   ```
2. Connect a device to the port you wish to test (e.g., USB drive for USB port).
3. Open PowerShell and run the appropriate script:
   ```powershell
   .\port-man-usb.ps1
   ```
4. Review the output to determine if any ports show signs of instability.

## ⚠️ Notes

- Ports must have a connected device to be successfully polled.
- A port with **10 or more disconnects** during a test should be considered for replacement.

## 🤝 Contributing

Contributions are welcome! If you'd like to add support for new port types or improve existing functionality:

1. Fork the repository  
2. Create a new branch  
3. Submit a pull request with a clear description of your changes

## 📜 License

This project is licensed under the [MIT License](LICENSE).
