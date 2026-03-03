#!/bin/bash

# --- Function for Banner ---
show_banner() {
    clear
    echo "===================================================="
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo "                                                    "
    echo "         SKA HOSTING - PANEL MANAGER                "
    echo "===================================================="
}

# --- OS Detection Logic ---
detect_os() {
    if [ -f /etc/debian_version ]; then
        PKG_MANAGER="apt"
        UPDATE_CMD="sudo apt update"
        INSTALL_CMD="sudo apt install -y"
        REMOVE_CMD="sudo apt purge -y"
    elif [ -f /etc/fedora-release ] || [ -f /etc/redhat-release ]; then
        PKG_MANAGER="dnf"
        UPDATE_CMD="sudo dnf check-update"
        INSTALL_CMD="sudo dnf install -y"
        REMOVE_CMD="sudo dnf remove -y"
    else
        echo "Unsupported OS! Exiting..."
        exit 1
    fi
}

# --- Installation Function ---
install_puffer() {
    echo -e "\n[1/5] Updating System..."
    eval $UPDATE_CMD
    $INSTALL_CMD wget git fastfetch

    echo -e "\n[2/5] Adding Repository..."
    if [ "$PKG_MANAGER" == "apt" ]; then
        curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
    else
        curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh | sudo bash
    fi

    echo -e "\n[3/5] Installing PufferPanel..."
    $INSTALL_CMD pufferpanel
    sudo systemctl enable --now pufferpanel

    echo -e "\n[4/5] Waiting for Database (10s)..."
    sleep 10

    echo -e "\n[5/5] Creating Admin Account..."
    sudo pufferpanel user add

    echo -e "\n✅ Installation Complete!"
    fastfetch
    echo "Admin Panel: http://$(hostname -I | awk '{print $1}'):8080"
}

# --- Uninstallation Function ---
uninstall_puffer() {
    echo -e "\n[!] Stopping and Disabling PufferPanel..."
    sudo systemctl stop pufferpanel
    sudo systemctl disable pufferpanel

    echo -e "\n[!] Removing PufferPanel Package..."
    $REMOVE_CMD pufferpanel

    echo -e "\n[!] Cleaning leftover files..."
    sudo rm -rf /etc/pufferpanel
    sudo rm -rf /var/lib/pufferpanel

    echo -e "\n✅ PufferPanel has been completely removed."
}

# --- Main Logic ---
show_banner
detect_os

echo "1. Install PufferPanel"
echo "2. Uninstall PufferPanel"
echo "3. Exit"
echo "----------------------------------------------------"
read -p "Select an option [1-3]: " main_choice

case $main_choice in
    1)
        install_puffer
        ;;
    2)
        uninstall_puffer
        ;;
    3)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid option. Restarting script..."
        sleep 2
        exec "$0"
        ;;
esac

# --- Press Enter to Exit ---
echo "----------------------------------------------------"
read -p "Press [Enter] to return..."
clear
