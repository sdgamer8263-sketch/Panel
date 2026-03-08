#!/bin/bash

# --- SDGAMER BANNER ---
clear
echo -e "\e[1;36m"
echo "  ____  ____   ____    _    __  __ _____ ____  "
echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
echo -e "\e[1;32m      CREATED BY SDGAMER - HYDRA PANEL\e[0m"
echo "------------------------------------------------"

echo "Select an Option:"
echo "1) Run Installation (Auto OS Detect)"
echo "2) Setup Node (HydraDAEMON)"
echo "3) Restart Dashboard & Daemon"
echo "------------------------------------------------"
read -p "Enter your choice [1-3]: " main_choice

# --- 1) INSTALLATION SECTION ---
if [ "$main_choice" == "1" ]; then
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    fi

    if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
        echo -e "\e[1;33mDetected $OS. Running Hydra1.sh...\e[0m"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
    elif [[ "$OS" == "fedora" ]]; then
        echo -e "\e[1;33mDetected Fedora. Running Hydra2.sh...\e[0m"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
    else
        echo -e "\e[1;31mUnsupported OS: $OS\e[0m"
    fi

# --- 2) NODE SETUP SECTION ---
elif [ "$main_choice" == "2" ]; then
    echo "Cloning HydraDAEMON..."
    git clone https://github.com/hydren-dev/HydraDAEMON
    cd HydraDAEMON || exit
    npm install
    echo "Paste your node configuration (Press Ctrl+D to save):"
    cat > config.json
    node .

# --- 3) RESTART SECTION ---
elif [ "$main_choice" == "3" ]; then
    echo "Starting Dashboard (oversee-fixed)..."
    cd ~/oversee-fixed || echo "Directory not found!"
    node . & 
    
    echo "------------------------------------------------"
    echo "Dashboard running in background."
    echo "Starting HydraDAEMON..."
    cd ~/HydraDAEMON || echo "Directory not found!"
    node .
else
    echo "Invalid choice!"
fi
