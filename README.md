### 🛠️ Sysadmin Scripts Kit : Network Status Checker

A simple, cross-platform Bash script to monitor the availability of network hosts (servers, routers, devices) using ICMP ping.

### ✨ Features

- **Cross-Platform:** Automatically detects the operating system (Windows via Git Bash/MSYS or Linux/macOS/WSL) and adapts the `ping` syntax accordingly.
- **Clean Output:** Hides the verbose ping statistics to display a clean, readable ✅ (Accessible) or ❌ (Unreachable) status.
- **Easy Configuration:** Reads target IP addresses and domain names from a simple `hosts.txt` file.
- **Smart Parsing:** Ignores empty lines and comments (lines starting with `#`) in the configuration file.

### 🚀 Getting Started

### 1. Prerequisites
- A bash environment (Linux, macOS, or Windows with Git Bash / WSL).

### 2. Setup
Clone this repository to your local machine:
```bash
git clone https://github.com/Kirua78/sysadmin-scripts-kit.git
cd sysadmin-scripts-kit
```

Security Note: Create your own hosts.txt file in the root directory. This project uses a .gitignore file to ensure your local IP addresses and private network configurations are never uploaded to GitHub.

Add your targets to the hosts.txt file, one per line:
```text
# Internet connectivity check
google.com
8.8.8.8
```

```text
# Local network devices for example
192.168.1.1
192.168.1.20
```

### 3. Usage
Run the script from your terminal:
```bash
bash network_checker.sh
```

### 🔧 Troubleshooting
Pinging Windows hosts from WSL (Windows Subsystem for Linux)
If you are running this script inside WSL and trying to ping your Windows host machine (or other Windows machines on the network), they might show up as ❌ INJOIGNABLE even if they are online.

This happens because the Windows Firewall blocks incoming ICMP requests from different subnets (like the WSL virtual network) by default.

```bash
Fix: Open a PowerShell as Administrator on the target Windows machine and run:
New-NetFirewallRule -Name "AllowPing" -DisplayName "Allow ICMPv4-In" -Protocol ICMPv4 -IcmpType 8 -Action Allow
```

### 📝 License
This project is for educational and personal use. Feel free to fork and modify it!