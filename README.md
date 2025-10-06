# nm-hotspot-cli

Simple command-line tool to create and manage Wi-Fi hotspots using NetworkManager.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hacktoberfest](https://img.shields.io/badge/Hacktoberfest-friendly-blueviolet)](https://hacktoberfest.com/)

## Features

- Simple and fast hotspot creation with a single command
- NetworkManager integration using nmcli
- Configuration management with persistent settings
- Status monitoring for active hotspots
- Colored terminal output for better readability
- WPA2 password protection
- Support for both 2.4GHz and 5GHz bands

## Requirements

- Arch Linux (or any Linux distribution)
- NetworkManager
- A wireless network interface that supports AP mode

## Project Structure

```
nm-hotspot-cli/
├── src/
│   └── nm-hotspot          # Main executable script
├── scripts/
│   ├── install.sh          # Installation script
│   └── uninstall.sh        # Uninstallation script
├── docs/
│   ├── CONTRIBUTING.md     # Contribution guidelines
│   ├── QUICKREF.md         # Quick reference guide
│   └── HACKTOBERFEST_ISSUES.md  # Issue templates
├── .github/
│   └── workflows/          # CI/CD workflows
├── Makefile                # Build and install targets
├── PKGBUILD                # Arch Linux package build file
├── .SRCINFO                # AUR metadata
├── LICENSE                 # MIT License
└── README.md               # This file
```

## Installation

### From AUR (Arch Linux)

Coming soon - PKGBUILD included in repository.

### Using Make

```bash
git clone https://github.com/HiddenKeyDev/nm-hotspot-cli.git
cd nm-hotspot-cli
sudo make install
```

To uninstall:
```bash
sudo make uninstall
```

### Quick Install Script

```bash
git clone https://github.com/HiddenKeyDev/nm-hotspot-cli.git
cd nm-hotspot-cli
chmod +x scripts/install.sh
./scripts/install.sh
```

For system-wide installation (requires sudo):
```bash
sudo ./scripts/install.sh
```

### Manual Installation

```bash
chmod +x src/nm-hotspot
cp src/nm-hotspot ~/.local/bin/nm-hotspot
# Or for system-wide: sudo cp src/nm-hotspot /usr/local/bin/nm-hotspot
```

### Install Dependencies (Arch Linux)

```bash
sudo pacman -S networkmanager
sudo systemctl enable NetworkManager
sudo systemctl start NetworkManager
```

## Usage

### Basic Commands

```bash
# Show help
nm-hotspot help

# Create a hotspot with default settings
nm-hotspot create

# Create a hotspot with custom settings
nm-hotspot create -s MyNetwork -p MyPassword123

# Create and save configuration as default
nm-hotspot create -s MyNetwork -p MyPassword123 --save

# Start existing hotspot
nm-hotspot start

# Stop the hotspot
nm-hotspot stop

# Check hotspot status
nm-hotspot status

# List available wireless devices
nm-hotspot list

# Show current configuration
nm-hotspot config

# View logs
nm-hotspot log

# View last 50 log entries
nm-hotspot log --tail 50

# Clear log file
nm-hotspot log --clear
```

### Command Options

**create** - Create and start a new hotspot
- `-s, --ssid SSID` - Set hotspot name (default: MyHotspot)
- `-p, --password PASS` - Set password (min 8 characters, default: 12345678)
- `-b, --band BAND` - Set band: `bg` (2.4GHz) or `a` (5GHz) (default: bg)
- `--save` - Save settings as default configuration

**start** - Start the existing hotspot connection

**stop** - Stop the active hotspot

**status** - Show current hotspot status and details

**list** - List all available wireless devices

**config** - Display saved configuration

**log** - Show log entries
- `--tail N` - Show last N log entries (default: 20)
- `--clear` - Clear the log file

## Examples

### Example 1: Quick Hotspot

```bash
# Create a hotspot with default settings
nm-hotspot create
# SSID: MyHotspot, Password: 12345678
```

### Example 2: Custom Configuration

```bash
# Create a 5GHz hotspot with custom name and password
nm-hotspot create -s "Coffee-Shop-WiFi" -p "SecurePass2024" -b a
```

### Example 3: Save Configuration

```bash
# Create and save as default
nm-hotspot create -s "MyHomeNetwork" -p "MySecurePassword" --save

# Later, just use:
nm-hotspot start
```

### Example 4: Check Status

```bash
nm-hotspot status
```

Output:
```
=== Hotspot Status ===
Status: ACTIVE
SSID: MyHomeNetwork
Band: bg (2.4GHz)
Device: wlan0
```

## Configuration

Configuration is stored in `~/.config/nm-hotspot/hotspot.conf`

Example configuration file:
```bash
# nm-hotspot configuration
SSID="MyHotspot"
PASSWORD="12345678"
BAND="bg"

# Logging settings
ENABLE_LOGGING=true
LOG_PRIVACY=false
```

### Logging

The logging system helps you troubleshoot issues and maintain an audit trail of hotspot operations.

**Enable logging:**

Edit `~/.config/nm-hotspot/hotspot.conf` and add:
```bash
ENABLE_LOGGING=true
```

**Log file location:**
`~/.config/nm-hotspot/nm-hotspot.log`

**Log entries include:**
- Timestamp
- Action performed (create, start, stop)
- SSID used (unless privacy mode is enabled)
- Success/failure status
- Error messages if any

**Example log output:**
```
[2024-10-06 14:30:15] INFO: Creating hotspot - Band: bg - SSID: MyHotspot
[2024-10-06 14:30:16] SUCCESS: Hotspot created successfully - SSID: MyHotspot
[2024-10-06 14:35:22] INFO: Stopping hotspot
[2024-10-06 14:35:23] SUCCESS: Hotspot stopped
[2024-10-06 14:40:10] ERROR: Failed to create hotspot - No wireless device found
```

**Privacy mode:**

To avoid logging sensitive information like SSIDs, enable privacy mode:
```bash
LOG_PRIVACY=true
```

**Log rotation:**

The log file is automatically rotated when it exceeds 1MB. The old log is saved as `nm-hotspot.log.old`.

## Troubleshooting

### Hotspot won't start

1. Check if your wireless adapter supports AP mode:
```bash
iw list | grep -A 10 "Supported interface modes"
```
Look for `AP` in the output.

2. Make sure NetworkManager is running:
```bash
systemctl status NetworkManager
```

3. Check for conflicts with other network services:
```bash
nmcli device status
```

### No wireless device found

Ensure your wireless adapter is detected:
```bash
nm-hotspot list
```

### Password issues

Password must be at least 8 characters long for WPA2 security.

## Uninstallation

```bash
./scripts/uninstall.sh
```

This will remove the `nm-hotspot` script and optionally remove configuration files.

## Contributing

Contributions are welcome. This project participates in Hacktoberfest.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Author

HiddenKeyDev

## Support

If you encounter issues or have questions:
- Open an issue on GitHub
- Check existing issues for solutions
- Submit pull requests for improvements
