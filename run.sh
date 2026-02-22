#!/bin/bash

# Colors for UI
CYAN='\033[0;36m'
MAGENTA='\033[1;35m'
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' 
BOLD='\033[1m'

# Function to show the sub-menu for Mythical Dash
mythical_submenu() {
    while true; do
        clear
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${MAGENTA}         MYTHICAL DASHBOARD VERSION SELECTION          ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}A)${NC} Mythical Dash Version - 3.0"
        echo -e "${GREEN}B)${NC} Mythical Dash Version - 4.0"
        echo -e "${YELLOW}0)${NC} Back to Main Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        
        read -p "Select version [A, B or 0]: " dash_choice
        
        case $dash_choice in
            A|a)
                bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Dashv3/udashv3.sh)
                break
                ;;
            B|b)
                bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/dashv4/udashv4.sh)
                break
                ;;
            0)
                return # Returns to the main menu loop
                ;;
            *)
                echo -e "${RED}Invalid option selected. Please try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Main Menu Loop
while true; do
    clear
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo -e "${MAGENTA}  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo -e "${WHITE}             WELCOME TO SDGAMER INSTALLER              ${NC}"
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo "Select an option to install:"
    echo -e "${GREEN}1)${NC} Control Panel"
    echo -e "${GREEN}2)${NC} Mythical Dash"
    echo -e "${GREEN}3)${NC} Pterodactyl Panel"
    echo -e "${GREEN}4)${NC} Jexactyl"
    echo -e "${GREEN}5)${NC} Jexapanel"
    echo -e "${GREEN}6)${NC} Payment Panel"
    echo -e "${GREEN}7)${NC} Reviactyl"
    echo -e "${GREEN}8)${NC} Feather Panel"
    echo -e "${GREEN}9)${NC} Feather Panel (Auto Install)"
    echo -e "${RED}0) Exit${NC}"
    echo -e "${CYAN}-------------------------------------------------------${NC}"

    read -p "Enter your choice [0-9]: " main_choice

    case $main_choice in
        1) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/ctrl/uctrl.sh) ;;
        2) mythical_submenu ;;
        3) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pterodactyl/upterodactyl.sh) ;;
        4) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexactyl/uJexactyl.sh) ;;
        5) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexapanel/Jp.sh) ;;
        6) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pay/upay.sh) ;;
        7) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/rev/urev.sh) ;;
        8) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/ufea.sh) ;;
        9) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/fea.sh) ;;
        0)
            echo -e "${YELLOW}Redirecting... Goodbye!${NC}"
            
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid selection. Try again.${NC}"
            sleep 1
            ;;
    esac
done
