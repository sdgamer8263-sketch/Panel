#!/bin/bash

# Define Colors for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- Function: Display SDGAMER Banner ---
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "${BLUE}        Hydra Panel Manager by SDGAMER${NC}"
    echo "================================================="
}

# --- Function: Install Panel (OS Detection) ---
install_panel() {
    echo -e "${YELLOW}[*] Detecting Operating System...${NC}"
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        
        if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then
            echo -e "${GREEN}[+] Detected $OS. Installing Hydra for Debian/Ubuntu...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra1.sh)
        elif [[ "$OS" == "fedora" ]]; then
            echo -e "${GREEN}[+] Detected $OS. Installing Hydra for Fedora...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/Hydra2.sh)
        else
            echo -e "${RED}[!] Unsupported OS Detected: $OS${NC}"
            echo "Please use Ubuntu, Debian, or Fedora."
        fi
    else
        echo -e "${RED}[!] Cannot detect OS. /etc/os-release not found.${NC}"
    fi
    read -p "Press Enter to return to menu..."
}

# --- Function: Add Node ---
add_node() {
    echo -e "${YELLOW}[*] Setting up HydraDAEMON Node...${NC}"
    
    # 1. Git Clone
    if [ -d "HydraDAEMON" ]; then
        echo -e "${YELLOW}[!] Directory HydraDAEMON already exists. Entering directory...${NC}"
    else
        git clone https://github.com/hydren-dev/HydraDAEMON || { echo -e "${RED}Clone failed${NC}"; return; }
    fi

    # 2. Enter Directory
    cd HydraDAEMON || { echo -e "${RED}Failed to enter directory${NC}"; return; }

    # 3. NPM Install
    echo -e "${YELLOW}[*] Installing dependencies...${NC}"
    npm install

    # 4. Configure
    echo -e "${GREEN}[*] Configuration Setup${NC}"
    read -p "Do you want to create/edit config.json now? (y/n): " edit_conf
    if [[ "$edit_conf" == "y" || "$edit_conf" == "Y" ]]; then
        nano config.json
    fi

    # 5. Start
    echo -e "${GREEN}[*] Starting Node...${NC}"
    node .
    
    # Return to previous directory
    cd ..
    read -p "Press Enter to return to menu..."
}

# --- Function: Start Services (Fixed Logic) ---
start_services() {
    show_banner
    echo -e "${YELLOW}[*] Service Management${NC}"
    echo "1) Start Dashboard (oversee-fixed)"
    echo "2) Start Node (HydraDAEMON)"
    echo "0) Back to Main Menu"
    echo ""
    read -p "Select service to start: " s_choice

    case $s_choice in
        1)
            if [ -d "oversee-fixed" ]; then
                cd oversee-fixed && node .
                cd ..
            else
                echo -e "${RED}[!] Directory 'oversee-fixed' not found.${NC}"
            fi
            ;;
        2)
            if [ -d "HydraDAEMON" ]; then
                cd HydraDAEMON && node .
                cd ..
            else
                echo -e "${RED}[!] Directory 'HydraDAEMON' not found.${NC}"
            fi
            ;;
        0) return ;;
        *) echo -e "${RED}Invalid option.${NC}" ;;
    esac
    read -p "Press Enter to continue..."
}

# --- Main Logic Loop ---
while true; do
    show_banner
    echo -e "${GREEN}1)${NC} Install Panel (Auto OS Detect)"
    echo -e "${GREEN}2)${NC} Add Node"
    echo -e "${GREEN}3)${NC} Start Services"
    echo -e "${RED}0)${NC} Exit"
    echo ""
    read -p "Select an option: " option

    case $option in
        1) install_panel ;;
        2) add_node ;;
        3) start_services ;;
        0) echo -e "${RED}Exiting...${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid option.${NC}"; sleep 1 ;;
    esac
done
