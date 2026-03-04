#!/bin/bash

# SDGAMER Banner Function
show_banner() {
    clear
    echo -e "\033[1;36m"
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "\033[0m"
    echo "================================================="
    echo "       PufferPanel Auto Installer Script         "
    echo "================================================="
}

# Root User Check
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (sudo su)"
    exit
fi

show_banner

# 1. OS Detection Logic
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    LIKE=$ID_LIKE
else
    echo "OS cannot be detected."
    exit 1
fi

echo "[*] Detected OS: $PRETTY_NAME"
sleep 2

# 2. Variable Setup based on OS
if [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$LIKE" == "debian" ]]; then
    # Settings for Debian/Ubuntu
    PACKAGE_MANAGER="apt"
    UPDATE_CMD="apt update && apt upgrade -y"
    INSTALL_CMD="apt install -y"
    REPO_SCRIPT="https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh"

elif [[ "$OS" == "fedora" || "$OS" == "centos" || "$OS" == "rhel" || "$LIKE" == "rhel" ]]; then
    # Settings for Fedora/RHEL
    PACKAGE_MANAGER="dnf"
    UPDATE_CMD="dnf update -y && dnf upgrade -y"
    INSTALL_CMD="dnf install -y"
    REPO_SCRIPT="https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh"
else
    echo "Unsupported OS. This script supports Ubuntu, Debian, Fedora, CentOS."
    exit 1
fi

# 3. Installation Process
echo "[*] Updating System using $PACKAGE_MANAGER..."
eval $UPDATE_CMD

echo "[*] Installing Dependencies (wget, git, fastfetch)..."
# Try installing fastfetch separately as it might not be in all repos, but others are critical
$INSTALL_CMD wget git
$INSTALL_CMD fastfetch 2>/dev/null || echo "Fastfetch could not be installed (skipping)."

echo "[*] Adding PufferPanel Repository..."
curl -s "$REPO_SCRIPT" | sudo bash

echo "[*] Installing PufferPanel..."
$INSTALL_CMD pufferpanel

echo "[*] Enabling PufferPanel Service..."
systemctl enable --now pufferpanel

echo "[*] Starting PufferPanel Service..."
systemctl start pufferpanel

echo "================================================="
echo "       Create PufferPanel Admin User             "
echo "================================================="
pufferpanel user add

# 4. Final Loop (Press Enter Only)
echo ""
echo "Installation Complete!"
while true; do
    read -p "Press Enter to return..." input
    if [[ -z "$input" ]]; then
        # Input is empty (User pressed Enter)
        break
    else
        # Input is not empty (User typed something else)
        echo "Invalid option"
    fi
done
