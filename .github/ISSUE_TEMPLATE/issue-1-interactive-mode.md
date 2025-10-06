---
name: Add interactive mode for hotspot creation
about: Add an interactive mode that prompts users for configuration
title: 'Add interactive mode for hotspot creation'
labels: 'enhancement, good first issue, hacktoberfest'
assignees: ''

---

## Description

Currently, users need to remember command-line flags to create a hotspot. Add an interactive mode that prompts users for configuration when no arguments are provided.

## Current behavior
```bash
nm-hotspot create
# Uses default values
```

## Desired behavior
```bash
nm-hotspot create --interactive
# or simply
nm-hotspot create -i

Enter SSID (default: MyHotspot): 
Enter password (min 8 chars, default: 12345678): 
Select band [1] 2.4GHz (bg) [2] 5GHz (a): 
Save as default? [y/N]: 
```

## Implementation hints
- Add a new flag `-i` or `--interactive` to the create command
- Use `read -p` for prompting user input
- Validate input before creating the hotspot
- Show current defaults in prompts
- Ask if user wants to save configuration

## Acceptance criteria
- [ ] Interactive mode works with `-i` or `--interactive` flag
- [ ] All inputs are validated (password length, band selection)
- [ ] User-friendly prompts with defaults shown
- [ ] Option to save configuration at the end
- [ ] Works alongside existing command-line arguments
- [ ] Documentation updated in README.md

## Difficulty
Easy - Good for beginners learning bash scripting
