#!/bin/bash

# --- Screen Clear ---
clear

# --- SDGAMER Banner ---
echo "===================================================="
echo "  ____  ____   ____    _    __  __ _____ ____  "
echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
echo "                                                    "
echo "         INSTALLATION STARTING FOR SKA HOSTING      "
echo "===================================================="
sleep 2

# 1 & 2. System Update and Upgrade
echo -e "\n[1/7] Updating and Upgrading System..."
sudo dnf upgrade -y

# 3, 4, 5. Install basic tools (wget, fastfetch, git)
echo -e "\n[2/7] Installing wget, fastfetch, and git..."
sudo dnf install wget fastfetch git -y

# 6. Add PufferPanel repository
echo -e "\n[3/7] Adding PufferPanel Repository..."
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh | sudo bash

# 7. Install PufferPanel
echo -e "\n[4/7] Installing PufferPanel..."
sudo dnf install pufferpanel -y

# 9 & 10. Enable and Start PufferPanel
echo -e "\n[5/7] Starting PufferPanel Service..."
sudo systemctl enable --now pufferpanel
sudo systemctl start pufferpanel

# Waiting for database initialization
echo -e "\n[6/7] Waiting 10 seconds for database setup..."
sleep 10

# 8. Add User (Interactive)
echo -e "\n[7/7] Creating Admin User..."
echo "----------------------------------------------------"
sudo pufferpanel user add
echo "----------------------------------------------------"

# Final touch with fastfetch
fastfetch

echo -e "\nInstallation Complete! Visit: http://your-ip:8080"
