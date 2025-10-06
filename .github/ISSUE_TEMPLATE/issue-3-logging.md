---
name: Implement logging functionality
about: Add logging system for debugging and audit trail
title: 'Implement logging system for debugging and audit trail'
labels: 'enhancement, good first issue, hacktoberfest'
assignees: ''

---

## Description

Add optional logging functionality to help users troubleshoot issues and maintain an audit trail of hotspot operations.

## Desired features

### Log file location
`~/.config/nm-hotspot/nm-hotspot.log`

### Log entries should include
- Timestamp
- Action performed (create, start, stop)
- SSID used
- Success/failure status
- Error messages if any

### New commands
```bash
nm-hotspot log           # Show last 20 log entries
nm-hotspot log --tail 50 # Show last 50 entries
nm-hotspot log --clear   # Clear log file
```

### Enable/disable via config
```bash
# In ~/.config/nm-hotspot/hotspot.conf
ENABLE_LOGGING=true
```

## Example log output
```
[2024-10-06 14:30:15] INFO: Creating hotspot - SSID: MyHotspot, Band: bg
[2024-10-06 14:30:16] SUCCESS: Hotspot created successfully
[2024-10-06 14:35:22] INFO: Stopping hotspot
[2024-10-06 14:35:23] SUCCESS: Hotspot stopped
[2024-10-06 14:40:10] ERROR: Failed to create hotspot - No wireless device found
```

## Implementation hints
- Create a `log_message()` function
- Add logging calls throughout the script
- Use date formatting: `date "+%Y-%m-%d %H:%M:%S"`
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
Easy-Medium - File operations and logging basics
