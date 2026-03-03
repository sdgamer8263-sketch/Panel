cat << 'EOF' > install_pufferpanel.sh
#!/bin/bash

# Clear screen for professional look
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

# 1 & 2. System Update & Upgrade
echo -e "\n[1/5] Updating System..."
sudo dnf upgrade -y

# 3, 4, 5. Installing basic tools
echo -e "\n[2/5] Installing wget, fastfetch, and git..."
sudo dnf install wget fastfetch git -y

# 6. Adding PufferPanel Repo
echo -e "\n[3/5] Adding PufferPanel Repository..."
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh | sudo bash

# 7. Installing PufferPanel
echo -e "\n[4/5] Installing PufferPanel..."
sudo dnf install pufferpanel -y

# 9 & 10. Start and Enable Service
echo -e "\n[5/5] Starting PufferPanel Service..."
sudo systemctl enable --now pufferpanel

# 8. User creation (Interactive)
echo -e "\n----------------------------------------------------"
echo "   Setup Finished! Now create your Admin Account:   "
echo "----------------------------------------------------"
sudo pufferpanel user add

EOF

# Permission change to make it executable
chmod +x install_pufferpanel.sh

# Run the script
./install_pufferpanel.sh
