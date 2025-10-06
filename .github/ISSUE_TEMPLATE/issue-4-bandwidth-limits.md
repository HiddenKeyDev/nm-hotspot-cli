---
name: Add bandwidth limiting and client management
about: Implement bandwidth limits and maximum client restrictions
title: 'Implement bandwidth limits and maximum client restrictions'
labels: 'enhancement, help wanted, hacktoberfest'
assignees: ''

---

## Description

Add the ability to limit bandwidth per client and restrict the maximum number of clients that can connect to the hotspot.

## Desired features

### Bandwidth limiting
```bash
nm-hotspot create -s MyHotspot -p Pass123 --max-rate 5M
# Limits each client to 5 Mbps
```

### Maximum clients
```bash
nm-hotspot create -s MyHotspot -p Pass123 --max-clients 5
# Allows maximum 5 clients
```

### Combined example
```bash
nm-hotspot create -s MyHotspot -p Pass123 \
  --max-clients 10 \
  --max-rate 10M \
  --save
```

### View limits in status
```bash
nm-hotspot status

=== Hotspot Status ===
Status: ACTIVE
SSID: MyHotspot
Max Clients: 10 (2 connected)
Bandwidth Limit: 10 Mbps per client
```

## Implementation hints
- Use NetworkManager configuration files in `/etc/NetworkManager/system-connections/`
- For bandwidth limiting, use `tc` (traffic control) commands
- For max clients, configure `dnsmasq` with `dhcp-host-max` option
- May need to modify NetworkManager connection settings directly
- Create helper functions to apply traffic shaping rules

## Technical resources
- `tc` command for bandwidth shaping
- NetworkManager connection configuration
- dnsmasq DHCP server options
- `nmcli connection modify` for updating settings

## Challenges
- May require root/sudo permissions
- Traffic control can be complex
- Need to clean up `tc` rules when stopping hotspot

## Acceptance criteria
- [ ] `--max-clients` flag works and limits connections
- [ ] `--max-rate` flag works and applies bandwidth limits
- [ ] Limits are shown in status output
- [ ] Limits can be saved in configuration
- [ ] Traffic shaping rules are properly cleaned up on stop
- [ ] Error handling for invalid values
- [ ] Root permission check if needed
- [ ] Comprehensive documentation
- [ ] Usage examples in README

## Difficulty
Hard - Advanced networking, traffic control, and system administration
