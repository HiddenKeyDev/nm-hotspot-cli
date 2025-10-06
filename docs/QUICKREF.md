# nm-hotspot-cli Quick Reference

## Installation
```bash
git clone https://github.com/HiddenKeyDev/nm-hotspot-cli.git
cd nm-hotspot-cli
./scripts/install.sh
```

Or using make:
```bash
sudo make install
```

## Quick Commands

| Command | Description |
|---------|-------------|
| `nm-hotspot create` | Create hotspot with defaults |
| `nm-hotspot create -s NAME -p PASS` | Create with custom name/password |
| `nm-hotspot start` | Start existing hotspot |
| `nm-hotspot stop` | Stop hotspot |
| `nm-hotspot status` | Check status |
| `nm-hotspot list` | List WiFi devices |
| `nm-hotspot config` | Show configuration |

## Common Use Cases

### Home Network Sharing
```bash
nm-hotspot create -s "Home-Guest" -p "GuestPass2024" --save
```

### Quick Temporary Hotspot
```bash
nm-hotspot create
# Use defaults, quick setup
```

### 5GHz High-Speed Hotspot
```bash
nm-hotspot create -s "FastNet" -p "SecurePass123" -b a
```

### Save and Reuse Configuration
```bash
# First time
nm-hotspot create -s "MyNetwork" -p "MyPassword" --save

# Later
nm-hotspot start
```

## Troubleshooting

### Check if device supports AP mode
```bash
iw list | grep -A 10 "Supported interface modes"
```

### Verify NetworkManager is running
```bash
systemctl status NetworkManager
```

### List all network devices
```bash
nm-hotspot list
```

### Manual cleanup if needed
```bash
nmcli connection delete nm-hotspot
```

## Configuration File
Location: `~/.config/nm-hotspot/hotspot.conf`

```bash
SSID="MyHotspot"
PASSWORD="12345678"
BAND="bg"
```

## Password Requirements
- Minimum 8 characters
- Required for WPA2 security

## Band Options
- `bg` - 2.4GHz (better range, more compatibility)
- `a` - 5GHz (faster speeds, less interference)

## Tips
- Use 2.4GHz for maximum device compatibility
- Use 5GHz for faster speeds in close range
- Save configuration for quick repeated use
- Check status to see active connections
- Stop hotspot when not needed to save battery

---
For full documentation, see [README.md](README.md)
