#!/bin/bash
#
# Installation script for nm-hotspot-cli
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}$1${NC}"
}

print_info() {
    echo -e "${YELLOW}$1${NC}"
}

echo "nm-hotspot-cli Installation Script"
echo "=================================="
echo ""

# Check if NetworkManager is installed
if ! command -v nmcli &> /dev/null; then
    print_error "NetworkManager is not installed!"
    echo "Install it with: sudo pacman -S networkmanager"
    exit 1
fi

# Determine installation directory
if [ "$EUID" -eq 0 ]; then
    INSTALL_DIR="/usr/local/bin"
    print_info "Installing system-wide to $INSTALL_DIR"
else
    INSTALL_DIR="$HOME/.local/bin"
    print_info "Installing for current user to $INSTALL_DIR"
    
    # Create directory if it doesn't exist
    mkdir -p "$INSTALL_DIR"
    
    # Check if directory is in PATH
    if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
        print_info "Note: $INSTALL_DIR is not in your PATH"
        echo "Add this line to your ~/.bashrc or ~/.zshrc:"
        echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    fi
fi

# Copy the script
print_info "Copying nm-hotspot to $INSTALL_DIR..."
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

if [ -f "$PROJECT_ROOT/src/nm-hotspot" ]; then
    cp "$PROJECT_ROOT/src/nm-hotspot" "$INSTALL_DIR/nm-hotspot"
elif [ -f "$PROJECT_ROOT/nm-hotspot" ]; then
    cp "$PROJECT_ROOT/nm-hotspot" "$INSTALL_DIR/nm-hotspot"
else
    print_error "Cannot find nm-hotspot script"
    exit 1
fi

chmod +x "$INSTALL_DIR/nm-hotspot"

print_success "Installation complete"
echo ""
echo "Usage: nm-hotspot --help"
echo ""
echo "Quick start:"
echo "  nm-hotspot create              # Create hotspot with defaults"
echo "  nm-hotspot create -s MyWiFi -p MyPassword123"
echo "  nm-hotspot stop"
echo "  nm-hotspot status"
