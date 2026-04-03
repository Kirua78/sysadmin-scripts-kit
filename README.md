# Sysadmin Scripts Kit

A simple, cross-platform Bash script toolkit to monitor network hosts, check ports, and track disk usage — works on Linux, macOS, and Windows (Git Bash / WSL).

---

## Features

- **Cross-Platform** - Automatically detects the OS (Windows, Linux, macOS, WSL) and adapts accordingly.
- **Clean Output** - Displays a readable ✔ / ✖ status without verbose ping noise.
- **Easy Configuration** - Reads hosts from a simple `hosts.txt` file.
- **Smart Parsing** - Ignores empty lines and `#` comments in config files.
- **Port Checking** - Test service availability (HTTP, SSH, DB...) on any host.
- **Disk Monitoring** - Real-time disk usage check with customizable alert threshold.

---

## Getting Started

### Prerequisites

- A Bash environment: Linux, macOS, or Windows with **Git Bash** or **WSL**.

### Installation

```bash
git clone https://github.com/Kirua78/sysadmin-scripts-kit.git
cd sysadmin-scripts-kit
```

> **Security note:** Create your own `hosts.txt` file locally. It is listed in `.gitignore` so your private IPs are never pushed to GitHub.

---

## Setup — Create your target list

The network scripts need a `hosts.txt` file with the hosts to check.

**Option A - Beginners (Mouse & Notepad)**

1. Right-click `hosts.example.txt` and choose **Copy**.
2. Paste it in the same folder.
3. Rename the copy to `hosts.txt`.
4. Open it with Notepad, add your IPs or domains (one per line), and save.

**Option B - Terminal**

```bash
# Linux / macOS / Git Bash
cp hosts.example.txt hosts.txt

# Windows PowerShell
Copy-Item hosts.example.txt hosts.txt
```

Then edit `hosts.txt` and add your targets:

```text
# Internet connectivity check
google.com
8.8.8.8
127.0.0.1
1.1.1.1

# Local network devices
192.168.1.1
192.168.1.20
```

---

## Network Tools

### Ping Checker

Checks if each host in `hosts.txt` is reachable.

```bash
bash Network/network_checker.sh
```

### Port Checker

Tests if a specific port is open on a host.

```bash
bash Network/port_checker.sh google.com 443
```

---

## System Tools

### Disk Monitor

Checks disk usage and alerts if it exceeds the configured threshold (default: 80%).

```bash
bash System/disk_monitor.sh
```

---

## Troubleshooting

### Windows hosts appear unreachable from WSL

Windows machines may show ✖ even when online. This is because the Windows Firewall blocks ICMP requests from the WSL virtual network by default.

**Fix** - Run this in PowerShell as Administrator on the target Windows machine:

```powershell
New-NetFirewallRule -Name "AllowPing" -DisplayName "Allow ICMPv4-In" -Protocol ICMPv4 -IcmpType 8 -Action Allow
```

---

## License

This project is for educational and personal use. Feel free to fork and modify it!
