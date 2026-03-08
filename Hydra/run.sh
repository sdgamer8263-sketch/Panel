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
    echo "1. Install Hydra (Auto-detect OS)"
    echo "2. Add Node & Configure"
    echo "3. Start Again (Oversee & HydraDAEMON)"
    echo "4. Exit"
    echo "==================================================="
    read -p "Select an option [1-4]: " choice

    case $choice in
        1)
            echo "Checking Operating System..."
            # Check for OS release file
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                OS_NAME=$ID
                LIKE_OS=$ID_LIKE
                
                # Logic for Ubuntu/Debian
                if [[ "$OS_NAME" == "ubuntu" || "$OS_NAME" == "debian" || "$LIKE_OS" == *"debian"* ]]; then
                    echo "Debian/Ubuntu detected. Running Hydra1..."
                    bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
                
                # Logic for Fedora
                elif [[ "$OS_NAME" == "fedora" || "$LIKE_OS" == *"fedora"* ]]; then
                    echo "Fedora detected. Running Hydra2..."
                    bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
                
                else
                    echo -e "\033[1;31mUnsupported OS detected: $OS_NAME\033[0m"
                fi
            else
                echo "Cannot detect OS information."
            fi
            read -p "Press Enter to return to menu..."
            ;;
        
        2)
            echo "Cloning HydraDAEMON..."
            git clone https://github.com/hydren-dev/HydraDAEMON
            
            if [ -d "HydraDAEMON" ]; then
                cd HydraDAEMON
                echo "Installing dependencies..."
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
                echo "Error: Directory HydraDAEMON not found."
            fi
            read -p "Press Enter to return to menu..."
            ;;
            
        3)
            echo "Starting Oversee and HydraDAEMON..."
            
            # Note: node . is usually a blocking command. 
            # If the first one runs effectively, the second might not start until the first stops.
            # Running exactly as requested:
            
            if [ -d "oversee-fixed" ]; then
                cd oversee-fixed
                node .
            else
                echo "Warning: oversee-fixed directory not found."
            fi

            if [ -d "../HydraDAEMON" ]; then
                cd ../HydraDAEMON
                node .
            elif [ -d "HydraDAEMON" ]; then
                cd HydraDAEMON
                node .
            else 
                echo "Warning: HydraDAEMON directory not found."
            fi
            
            read -p "Press Enter to return to menu..."
            ;;
            
        4)
            echo "Exiting..."
            exit 0
            ;;
            
        *)
            echo "Invalid option."
            read -p "Press Enter to continue..."
            ;;
    esac
done
