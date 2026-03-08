#!/bin/bash

# --- SDGAMER BANNER ---
echo -e "\e[1;34m"
echo "  ____  ____   ____    _    __  __ _____ ____  "
echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
echo -e "\e[1;32m      CREATED BY SDGAMER - HYDRA PANEL\e[0m"
echo "------------------------------------------------"

# --- OS DETECTION & INSTALLATION ---
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

case "$OS" in
    ubuntu|debian)
        echo "Detected $OS. Running Hydra1.sh..."
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
        ;;
    fedora)
        echo "Detected Fedora. Running Hydra2.sh..."
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

echo "------------------------------------------------"
echo "Select an option:"
echo "1) Setup HydraDAEMON (Node Option)"
echo "2) Restart Services (Again Start)"
echo "------------------------------------------------"
read -p "Enter choice [1-2]: " choice

if [ "$choice" == "1" ]; then
    # --- NODE OPTION ---
    echo "Setting up HydraDAEMON..."
    git clone https://github.com/hydren-dev/HydraDAEMON
    cd HydraDAEMON
    npm install
    echo "Please paste your node configuration now (Press Ctrl+D when finished):"
    cat > config.json # Assuming config needs to be saved to a file
    node .

elif [ "$choice" == "2" ]; then
    # --- AGAIN START ---
    echo "Starting Dashboard and Daemon..."
    
    # Start Dashboard in a background process or screen
    cd ~/oversee-fixed
    echo "Starting Dashboard..."
    node . & 

    # Instruct user for new terminal
    echo "------------------------------------------------"
    echo "Dashboard started in background."
    echo "Opening HydraDAEMON..."
    cd ~/HydraDAEMON
    node .
fi
