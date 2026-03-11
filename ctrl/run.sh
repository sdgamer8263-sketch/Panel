#!/bin/bash

# Color Codes for Styling
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BG_BLUE='\033[44m'
NC='\033[0m' # No Color

# Function to display the SDGAMER banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo "                                               "
    echo -e "${NC}"
    echo -e "${YELLOW}===============================================${NC}"
}

# Function to display the background list/menu
show_menu() {
    show_banner
    # The text below uses a blue background as requested for the list
    echo -e "${BG_BLUE}${GREEN} Please select an option from the list below: ${NC}\n"
    echo -e "${CYAN}1.${NC} Install (Run ctrl.sh)"
    echo -e "${CYAN}2.${NC} Uninstall (Run uctrl.sh.sh)"
    echo -e "${CYAN}3.${NC} Exit\n"
    echo -e "${YELLOW}===============================================${NC}"
}

# Main Script Logic
while true; do
    show_menu
    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            echo -e "\n${GREEN}[+] Starting Installation...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/ctrl/ctrl.sh)
            echo -e "\n${GREEN}[✔] Install script execution finished.${NC}"
            read -p "Press Enter to return to the menu..."
            ;;
        2)
            echo -e "\n${RED}[+] Starting Uninstallation...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/ctrl/uctrl.sh.sh)
            echo -e "\n${GREEN}[✔] Uninstall script execution finished.${NC}"
            read -p "Press Enter to return to the menu..."
            ;;
        3)
            echo -e "\n${YELLOW}Exiting...${NC}"
            exit 0
            ;;
        *)
            echo -e "\n${RED}[!] Invalid option. Please select 1, 2, or 3.${NC}"
            read -p "Press Enter to try again..."
            ;;
    esac
done

