#!/bin/bash
# 
# Script to create GitHub issues for Hacktoberfest
# Run this after authenticating with: gh auth login
#

REPO="HiddenKeyDev/nm-hotspot-cli"

echo "Creating Hacktoberfest issues for $REPO..."

# Issue 1: Interactive Mode
gh issue create \
  --repo "$REPO" \
  --title "Add interactive mode for hotspot creation" \
  --label "enhancement,good first issue,hacktoberfest" \
  --body "## Description

Currently, users need to remember command-line flags to create a hotspot. Add an interactive mode that prompts users for configuration when no arguments are provided.

## Current behavior
\`\`\`bash
nm-hotspot create
# Uses default values
\`\`\`

## Desired behavior
\`\`\`bash
nm-hotspot create --interactive
# or simply
nm-hotspot create -i

Enter SSID (default: MyHotspot): 
Enter password (min 8 chars, default: 12345678): 
Select band [1] 2.4GHz (bg) [2] 5GHz (a): 
Save as default? [y/N]: 
\`\`\`

## Implementation hints
- Add a new flag \`-i\` or \`--interactive\` to the create command
- Use \`read -p\` for prompting user input
- Validate input before creating the hotspot
- Show current defaults in prompts
- Ask if user wants to save configuration

## Acceptance criteria
- [ ] Interactive mode works with \`-i\` or \`--interactive\` flag
- [ ] All inputs are validated (password length, band selection)
- [ ] User-friendly prompts with defaults shown
- [ ] Option to save configuration at the end
- [ ] Works alongside existing command-line arguments
- [ ] Documentation updated in README.md

## Difficulty
Easy - Good for beginners learning bash scripting"

echo "Created Issue #1: Interactive Mode"

# Issue 2: Connected Clients
gh issue create \
  --repo "$REPO" \
  --title "Show list of connected clients with MAC addresses and connection time" \
  --label "enhancement,hacktoberfest" \
  --body "## Description

Enhance the \`status\` command to display information about currently connected clients to the hotspot, including MAC addresses, hostnames (if available), and connection duration.

## Current behavior
\`\`\`bash
nm-hotspot status
# Shows basic hotspot status only
\`\`\`

## Desired behavior
\`\`\`bash
nm-hotspot status

=== Hotspot Status ===
Status: ACTIVE
SSID: MyHotspot
Band: bg (2.4GHz)
Device: wlan0

Connected Clients (2):
  1. AA:BB:CC:DD:EE:FF - hostname-1 - Connected: 5m 23s
  2. 11:22:33:44:55:66 - hostname-2 - Connected: 1m 45s
\`\`\`

## Implementation hints
- Use \`arp -n\` to get connected devices on the hotspot subnet
- Parse DHCP lease file at \`/var/lib/NetworkManager/dnsmasq-*.leases\`
- Alternatively use \`iw dev <device> station dump\` for WiFi stats
- Calculate connection duration if timestamp available
- Handle cases with no connected clients gracefully

## Resources
- NetworkManager DHCP leases location
- \`iw\` command for station information
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
Medium - Requires system administration and networking knowledge"

echo "Created Issue #2: Connected Clients"

# Issue 3: Logging
gh issue create \
  --repo "$REPO" \
  --title "Implement logging system for debugging and audit trail" \
  --label "enhancement,good first issue,hacktoberfest" \
  --body "## Description

Add optional logging functionality to help users troubleshoot issues and maintain an audit trail of hotspot operations.

## Desired features

### Log file location
\`~/.config/nm-hotspot/nm-hotspot.log\`

### Log entries should include
- Timestamp
- Action performed (create, start, stop)
- SSID used
- Success/failure status
- Error messages if any

### New commands
\`\`\`bash
nm-hotspot log           # Show last 20 log entries
nm-hotspot log --tail 50 # Show last 50 entries
nm-hotspot log --clear   # Clear log file
\`\`\`

### Enable/disable via config
\`\`\`bash
# In ~/.config/nm-hotspot/hotspot.conf
ENABLE_LOGGING=true
\`\`\`

## Example log output
\`\`\`
[2024-10-06 14:30:15] INFO: Creating hotspot - SSID: MyHotspot, Band: bg
[2024-10-06 14:30:16] SUCCESS: Hotspot created successfully
[2024-10-06 14:35:22] INFO: Stopping hotspot
[2024-10-06 14:35:23] SUCCESS: Hotspot stopped
[2024-10-06 14:40:10] ERROR: Failed to create hotspot - No wireless device found
\`\`\`

## Implementation hints
- Create a \`log_message()\` function
- Add logging calls throughout the script
- Use date formatting: \`date \"+%Y-%m-%d %H:%M:%S\"\`
- Implement log rotation if file exceeds certain size (e.g., 1MB)
- Add privacy option to avoid logging SSIDs/passwords

## Acceptance criteria
- [ ] Logging can be enabled/disabled via config
- [ ] Log file created in correct location
- [ ] All major actions are logged
- [ ] Log viewing command works
- [ ] Log clearing command works
- [ ] Log rotation implemented
- [ ] Documentation added to README
- [ ] Privacy-conscious (option to not log sensitive data)

## Difficulty
Easy-Medium - File operations and logging basics"

echo "Created Issue #3: Logging System"

# Issue 4: Bandwidth Limits
gh issue create \
  --repo "$REPO" \
  --title "Implement bandwidth limits and maximum client restrictions" \
  --label "enhancement,help wanted,hacktoberfest" \
  --body "## Description

Add the ability to limit bandwidth per client and restrict the maximum number of clients that can connect to the hotspot.

## Desired features

### Bandwidth limiting
\`\`\`bash
nm-hotspot create -s MyHotspot -p Pass123 --max-rate 5M
# Limits each client to 5 Mbps
\`\`\`

### Maximum clients
\`\`\`bash
nm-hotspot create -s MyHotspot -p Pass123 --max-clients 5
# Allows maximum 5 clients
\`\`\`

### Combined example
\`\`\`bash
nm-hotspot create -s MyHotspot -p Pass123 \\
  --max-clients 10 \\
  --max-rate 10M \\
  --save
\`\`\`

### View limits in status
\`\`\`bash
nm-hotspot status

=== Hotspot Status ===
Status: ACTIVE
SSID: MyHotspot
Max Clients: 10 (2 connected)
Bandwidth Limit: 10 Mbps per client
\`\`\`

## Implementation hints
- Use NetworkManager configuration files in \`/etc/NetworkManager/system-connections/\`
- For bandwidth limiting, use \`tc\` (traffic control) commands
- For max clients, configure \`dnsmasq\` with \`dhcp-host-max\` option
- May need to modify NetworkManager connection settings directly
- Create helper functions to apply traffic shaping rules

## Technical resources
- \`tc\` command for bandwidth shaping
- NetworkManager connection configuration
- dnsmasq DHCP server options
- \`nmcli connection modify\` for updating settings

## Challenges
- May require root/sudo permissions
- Traffic control can be complex
- Need to clean up \`tc\` rules when stopping hotspot

## Acceptance criteria
- [ ] \`--max-clients\` flag works and limits connections
- [ ] \`--max-rate\` flag works and applies bandwidth limits
- [ ] Limits are shown in status output
- [ ] Limits can be saved in configuration
- [ ] Traffic shaping rules are properly cleaned up on stop
- [ ] Error handling for invalid values
- [ ] Root permission check if needed
- [ ] Comprehensive documentation
- [ ] Usage examples in README

## Difficulty
Hard - Advanced networking, traffic control, and system administration"

echo "Created Issue #4: Bandwidth Limits"

echo ""
echo "All 4 Hacktoberfest issues created successfully!"
