#!/bin/bash
#
# Uninstallation script for nm-hotspot-cli
#

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${YELLOW}$1${NC}"
}

echo "nm-hotspot-cli Uninstallation Script"
echo "===================================="
echo ""

# Determine installation directory
if [ "$EUID" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
else
    INSTALL_DIR="$HOME/.local/bin"
fi

# Remove the script
if [ -f "$INSTALL_DIR/nm-hotspot" ]; then
    print_info "Removing nm-hotspot from $INSTALL_DIR..."
    rm "$INSTALL_DIR/nm-hotspot"
    print_success "nm-hotspot removed"
else
    print_info "nm-hotspot not found in $INSTALL_DIR"
fi

# Ask about configuration
read -p "Remove configuration files? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if [ -d "$HOME/.config/nm-hotspot" ]; then
        rm -rf "$HOME/.config/nm-hotspot"
        print_success "Configuration removed"
    fi
fi

print_success "Uninstallation complete"
