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
        echo -e "${RED}Directory HydraDAEMON already exists. Skipping clone.${NC}"
    else
        git clone https://github.com/hydren-dev/HydraDAEMON
    fi

    # 2. Enter Directory
    cd HydraDAEMON || { echo "Failed to enter directory"; return; }

    # 3. NPM Install
    echo -e "${YELLOW}[*] Installing dependencies...${NC}"
    npm install

    # 4. Configure
    echo -e "${GREEN}[*] Create your configuration file.${NC}"
    echo "Please create/paste your configuration (usually config.json or config.yml)."
    echo "Use 'nano config.json' to edit manually if needed."
    read -p "Press Enter to open nano editor to paste your config (Save with Ctrl+O, Exit with Ctrl+X)..."
    nano config.json

    # 5. Start
    echo -e "${GREEN}[*] Starting Node...${NC}"
    node .
    
    # Return to previous directory
    cd ..
    read -p "Press Enter to return to menu..."
}

# --- Function: Again Start (Restart Services) ---
start_services() {
    echo -e "${YELLOW}[*] Instructions to Restart Dashboard & Daemon${NC}"
    echo "================================================="
    
    echo -e "${CYAN}Terminal 1 (Dashboard):${NC}"
    echo "  1) cd oversee-fixed"
    echo "  2) node ."
    echo ""
    echo -e "${CYAN}Terminal 2 (Daemon/Node):${NC}"
    echo "  3) Create a new terminal session (+)"
    echo "  4) cd HydraDAEMON"
    echo "  5) node ."
    echo "================================================="
    
    read -p "Do you want to run the Dashboard (Terminal 1) now? (y/n): " choice
    if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
        if [ -d "oversee-fixed" ]; then
            cd oversee-fixed
            node .
            cd ..
        else
            echo -e "${RED}[!] Directory 'oversee-fixed' not found.${NC}"
        fi
    fi
    read -p "Press Enter to return to menu..."
}

# --- Main Logic Loop ---
while true; do
    show_banner
    echo -e "${GREEN}1)${NC} Install Panel (Auto OS Detect)"
    echo -e "${GREEN}2)${NC} Add Node"
    echo -e "${GREEN}3)${NC} Start Services (Again Start)"
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
