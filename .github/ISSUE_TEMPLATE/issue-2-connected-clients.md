---
name: Display connected clients information
about: Show list of connected clients with MAC addresses and connection time
title: 'Show list of connected clients with MAC addresses and connection time'
labels: 'enhancement, hacktoberfest'
assignees: ''

---

## Description

Enhance the `status` command to display information about currently connected clients to the hotspot, including MAC addresses, hostnames (if available), and connection duration.

## Current behavior
```bash
nm-hotspot status
# Shows basic hotspot status only
```

## Desired behavior
```bash
nm-hotspot status

=== Hotspot Status ===
Status: ACTIVE
SSID: MyHotspot
Band: bg (2.4GHz)
Device: wlan0

Connected Clients (2):
  1. AA:BB:CC:DD:EE:FF - hostname-1 - Connected: 5m 23s
  2. 11:22:33:44:55:66 - hostname-2 - Connected: 1m 45s
```

## Implementation hints
- Use `arp -n` to get connected devices on the hotspot subnet
- Parse DHCP lease file at `/var/lib/NetworkManager/dnsmasq-*.leases`
- Alternatively use `iw dev <device> station dump` for WiFi stats
- Calculate connection duration if timestamp available
- Handle cases with no connected clients gracefully

## Resources
- NetworkManager DHCP leases location
- `iw` command for station information
- ARP table parsing in bash

## Acceptance criteria
- [ ] Shows count of connected clients
- [ ] Displays MAC address for each client
- [ ] Shows hostname when available
- [ ] Shows connection duration when available
- [ ] Handles zero clients gracefully
- [ ] Error handling for permission issues
- [ ] Updated README with new output format

## Difficulty
Medium - Requires system administration and networking knowledge
