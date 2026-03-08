#!/bin/bash

# SDGAMER Menu Script
# Author: SDGAMER
# Description: Automates Hydra Panel installation and Node management

# Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to display the banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "  ____  ____   ____    _    __  __  ____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  || ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| ||  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | || |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_||_____|_| \_\\"
    echo -e "${NC}"
    echo -e "${BLUE}       Hydra Panel Automation Tool${NC}"
    echo -e "${BLUE}       Created by SDGAMER${NC}"
    echo "-------------------------------------------------"
}

# Function for Option 1: Install with OS Detection
install_panel() {
    echo -e "${YELLOW}Checking OS Distribution...${NC}"
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
    else
        echo -e "${RED}Cannot detect OS. Exiting.${NC}"
        return
    fi

    if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
        echo -e "${GREEN}Detected $OS. Running Hydra1.sh...${NC}"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
    elif [[ "$OS" == "fedora" ]]; then
        echo -e "${GREEN}Detected Fedora. Running Hydra2.sh...${NC}"
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
    else
        echo -e "${RED}Unsupported OS: $OS${NC}"
    fi
}

# Function for Option 2: Add Node
add_node() {
    echo -e "${GREEN}Cloning HydraDAEMON...${NC}"
    git clone https://github.com/hydren-dev/HydraDAEMON
    
    cd HydraDAEMON || { echo -e "${RED}Directory not found!${NC}"; return; }
    
    echo -e "${GREEN}Installing dependencies...${NC}"
    npm install

    echo -e "${YELLOW}-------------------------------------------------${NC}"
    echo -e "${YELLOW}ACTION REQUIRED: Configure your Node${NC}"
    echo -e "Please create/edit your config file now."
    echo -e "Use commands like 'nano config.json' (or appropriate filename) to paste your config."
    echo -e "${YELLOW}-------------------------------------------------${NC}"
    
    # Pausing the script to let the user configure manually if needed, 
    # or you can open nano directly if you know the filename (e.g., nano config.json)
    read -p "Press Enter AFTER you have pasted your configuration file to start the node..."

    echo -e "${GREEN}Starting Node...${NC}"
    node .
}

# Function for Option 3: Start Again
start_again() {
    echo -e "${GREEN}Starting Services...${NC}"
    
    # Check if directories exist
    if [ -d "oversee-fixed" ]; then
        echo -e "${CYAN}Starting Oversee...${NC}"
        cd oversee-fixed
        # Using '&' to run in background so the script can continue to the next command
        # If you want them to run in the foreground, remove '&' but the script will stop here.
        node . & 
        cd ..
    else
        echo -e "${RED}Folder 'oversee-fixed' not found!${NC}"
    fi

    sleep 2

    if [ -d "HydraDAEMON" ]; then
        echo -e "${CYAN}Starting HydraDAEMON...${NC}"
        cd HydraDAEMON
        node .
    else
        echo -e "${RED}Folder 'HydraDAEMON' not found!${NC}"
    fi
}

# Main Menu Loop
while true; do
    show_banner
    echo -e "${YELLOW}1)${NC} Install Panel (Auto OS Detect)"
    echo -e "${YELLOW}2)${NC} Add Node"
    echo -e "${YELLOW}3)${NC} Start Services (Again Start)"
    echo -e "${YELLOW}4)${NC} Exit"
    echo ""
    read -p "Select an option [1-4]: " choice

    case $choice in
        1)
            install_panel
            read -p "Press Enter to return to menu..."
            ;;
        2)
            add_node
            read -p "Press Enter to return to menu..."
            ;;
        3)
            start_again
            # Note: Since 'node .' usually runs forever, this might not return to menu automatically
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            sleep 1
            ;;
    esac
done
