#!/bin/bash

# Function to display the banner
show_banner() {
    clear
    echo -e "\033[1;36m"
    echo "  ____  ____   ____    _    __  __  ____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  || ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| ||  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | || |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_||_____|_| \_\\"
    echo -e "\033[0m"
    echo -e "\033[1;32m      Hydra Management Script \033[0m"
    echo "==================================================="
}

# Main Logic
while true; do
    show_banner
    echo "1. Full Setup (Install Hydra + Add Node)"
    echo "2. Start Existing (Oversee & HydraDAEMON)"
    echo "3. Exit"
    echo "==================================================="
    read -p "Select an option [1-3]: " choice

    case $choice in
        1)
            # --- STEP 1: INSTALL HYDRA (OS DETECTION) ---
            echo "Checking Operating System..."
            OS_INSTALLED=false
            
            # Check for OS release file
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                OS_NAME=$ID
                LIKE_OS=$ID_LIKE
                
                # Logic for Ubuntu/Debian
                if [[ "$OS_NAME" == "ubuntu" || "$OS_NAME" == "debian" || "$LIKE_OS" == *"debian"* ]]; then
                    echo "Debian/Ubuntu detected. Running Hydra1..."
                    bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
                    OS_INSTALLED=true
                
                # Logic for Fedora
                elif [[ "$OS_NAME" == "fedora" || "$LIKE_OS" == *"fedora"* ]]; then
                    echo "Fedora detected. Running Hydra2..."
                    bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
                    OS_INSTALLED=true
                
                else
                    echo -e "\033[1;31mUnsupported OS detected: $OS_NAME\033[0m"
                fi
            else
                echo "Cannot detect OS information."
            fi

            # --- STEP 2: NODE CONFIGURATION (Runs only if OS check passed) ---
            if [ "$OS_INSTALLED" = true ]; then
                echo "---------------------------------------------------"
                echo "Hydra Core Installation Complete."
                echo "Proceeding to Node Setup..."
                echo "---------------------------------------------------"
                sleep 2

                echo "Cloning HydraDAEMON..."
                # Check if directory exists to avoid git error
                if [ -d "HydraDAEMON" ]; then
                    echo "HydraDAEMON directory already exists. Skipping clone..."
                else
                    git clone https://github.com/hydren-dev/HydraDAEMON
                fi
                
                if [ -d "HydraDAEMON" ]; then
                    cd HydraDAEMON
                    echo "Installing dependencies (npm install)..."
                    npm install
                    
                    echo "---------------------------------------------------"
                    echo -e "\033[1;33mACTION REQUIRED:\033[0m"
                    echo "Please paste/setup your configuration files now."
                    echo "Once you have finished configuring, press Enter to start the node."
                    echo "---------------------------------------------------"
                    read -p ""
                    
                    echo "Starting Node..."
                    node .
                else
                    echo "Error: Directory HydraDAEMON could not be created."
                fi
            fi
            
            read -p "Press Enter to return to menu..."
            ;;
            
        2)
            echo "Starting Oversee and HydraDAEMON..."
            
            # Start Oversee
            if [ -d "oversee-fixed" ]; then
                echo "Starting Oversee..."
                cd oversee-fixed
                # Running in background to avoid blocking
                node . & 
                cd ..
            else
                echo "Warning: oversee-fixed directory not found."
            fi

            sleep 2

            # Start HydraDAEMON
            if [ -d "HydraDAEMON" ]; then
                echo "Starting HydraDAEMON..."
                cd HydraDAEMON
                node .
            else 
                echo "Warning: HydraDAEMON directory not found."
            fi
            
            read -p "Press Enter to return to menu..."
            ;;
            
        3)
            echo "Exiting..."
            exit 0
            ;;
            
        *)
            echo "Invalid option."
            read -p "Press Enter to continue..."
            ;;
    esac
done
