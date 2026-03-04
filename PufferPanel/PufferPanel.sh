#!/bin/bash

# --- SDGAMER PufferPanel Auto-Installer ---

# 0. Get Root Access
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root or use: sudo bash install.sh"
  exit
fi

# 1 & 2. System Update & Upgrade
echo "Starting System Update..."
dnf update -y && dnf upgrade -y

# 3, 4, & 5. Install Dependencies
echo "Installing Utilities (wget, git, fastfetch)..."
dnf install wget fastfetch git -y

# 6. Add PufferPanel Repository
echo "Adding PufferPanel Repository..."
curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh | bash

# 7. Install PufferPanel
echo "Installing PufferPanel..."
dnf install pufferpanel -y

# 9 & 10. Enable and Start Service
echo "Starting PufferPanel Service..."
systemctl enable --now pufferpanel

# 8. Add User (Interactive Section)
# Note: If user gives bhul input, it will show "Invalid option" and stay here.
echo "--------------------------------------------------------"
echo "SETTING UP ADMIN USER (Follow prompts carefully)"
echo "--------------------------------------------------------"
pufferpanel user add

# --- Final Banner & System Info ---
clear
echo "========================================================"
echo "                INSTALLATION COMPLETE                   "
echo "========================================================"
echo "  ____  ____   ____    _    __  __ _____ ____  "
echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
echo "                                                "
echo "                CREATED BY SDGAMER              "
echo "========================================================"
echo ""

# Show System Specs
fastfetch

echo ""
echo "Access your panel at: http://YOUR_IP:8080"
