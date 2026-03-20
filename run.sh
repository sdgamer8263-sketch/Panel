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

# Function to print the SDGAMER Banner
print_banner() {
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo -e "${MAGENTA}  ____  ____   ____    _    __  __ _____ ____  "
    echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
    echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
    echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
    echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo -e "${WHITE}             WELCOME TO SDGAMER INSTALLER              ${NC}"
    echo -e "${CYAN}-------------------------------------------------------${NC}"
}

# Function for Mythical Dash Version Selection
mythical_submenu() {
    while true; do
        clear
        print_banner
        echo -e "${MAGENTA}         MYTHICAL DASHBOARD VERSION SELECTION          ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}A)${NC} Mythical Dash Version - 3.0"
        echo -e "${GREEN}B)${NC} Mythical Dash Version - 4.0"
        echo -e "${YELLOW}0)${NC} Back to Dashboard Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        
        read -p "Select version [A, B or 0]: " dash_choice
        
        case $dash_choice in
            A|a)
                bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Dashv3/udashv3.sh)
                ;;
            B|b)
                bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/dashv4/udashv4.sh)
                ;;
            0)
                return # Returns to the previous menu
                ;;
            *)
                echo -e "${RED}Invalid option selected. Please try again.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Function for Feather Panel Submenu
feather_submenu() {
    while true; do
        clear
        print_banner
        echo -e "${MAGENTA}                 FEATHER PANEL MENU                    ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}1)${NC} Feather Panel"
        echo -e "${GREEN}2)${NC} Feather Panel (Auto Install)"
        echo -e "${YELLOW}0)${NC} Back to Panels Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"

        read -p "Select an option [1, 2 or 0]: " fea_choice

        case $fea_choice in
            1) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/ufea.sh) ;;
            2) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/fea.sh) ;;
            0) return ;;
            *) echo -e "${RED}Invalid selection. Try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Function for Jexactyl Panel Submenu
jexactyl_submenu() {
    while true; do
        clear
        print_banner
        echo -e "${MAGENTA}             JEXACTYL PANEL & DASH MENU                ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}1)${NC} Jexactyl"
        echo -e "${GREEN}2)${NC} Jexapanel"
        echo -e "${YELLOW}0)${NC} Back to Panels Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"

        read -p "Select an option [1, 2 or 0]: " jex_choice

        case $jex_choice in
            1) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexactyl/uJexactyl.sh) ;;
            2) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexapanel/Jp.sh) ;;
            0) return ;;
            *) echo -e "${RED}Invalid selection. Try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Function for Main Panels Menu
panels_menu() {
    while true; do
        clear
        print_banner
        echo -e "${MAGENTA}                      PANELS MENU                      ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}1)${NC} Pterodactyl Panel"
        echo -e "${GREEN}2)${NC} Puffer Panel"
        echo -e "${GREEN}3)${NC} Reviactyl"
        echo -e "${GREEN}4)${NC} Feather Panel"
        echo -e "${GREEN}5)${NC} Jexactyl Panel and Dash"
        echo -e "${GREEN}6)${NC} Skyport Panel"
        echo -e "${GREEN}7)${NC} Airlink Panel (by Jishnu Bhi)"
        echo -e "${GREEN}8)${NC} Hydra Panel"
        echo -e "${GREEN}9)${NC} Oversee Panel"
        echo -e "${GREEN}10)${NC} Darco Panel"
        echo -e "${YELLOW}0)${NC} Back to Main Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"

        read -p "Enter your choice [0-10]: " panel_choice

        case $panel_choice in
            1) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pterodactyl/upterodactyl.sh) ;;
            2) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/PufferPanel/PufferPanel.sh) ;;
            3) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/rev/urev.sh) ;;
            4) feather_submenu ;;
            5) jexactyl_submenu ;;
            6) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Skyport/run.sh) ;;
            7) bash <(curl -s https://airlink.jishnu.fun) ;;
            8) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Hydra/run.sh) ;;
            9) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Oversee/run.sh) ;;
            10) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Darco/run.sh) ;;
            0) return ;;
            *) echo -e "${RED}Invalid selection. Try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Function for Dashboard Menu
dashboard_menu() {
    while true; do
        clear
        print_banner
        echo -e "${MAGENTA}                    DASHBOARD MENU                     ${NC}"
        echo -e "${CYAN}-------------------------------------------------------${NC}"
        echo -e "${GREEN}1)${NC} Mythical Dash"
        echo -e "${GREEN}2)${NC} Heliactyl Dashboard(soon)"
        echo -e "${YELLOW}0)${NC} Back to Main Menu"
        echo -e "${CYAN}-------------------------------------------------------${NC}"

        read -p "Enter your choice [0-2]: " dash_main_choice

        case $dash_main_choice in
            1) mythical_submenu ;;
            2) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/skost/main/run.sh) ;;
            0) return ;;
            *) echo -e "${RED}Invalid selection. Try again.${NC}"; sleep 1 ;;
        esac
    done
}

# Main Menu Loop
while true; do
    clear
    print_banner
    echo -e "${MAGENTA}                      MAIN MENU                        ${NC}"
    echo -e "${CYAN}-------------------------------------------------------${NC}"
    echo "Select an option to install:"
    echo -e "${GREEN}1)${NC} Panels"
    echo -e "${GREEN}2)${NC} DashBoard"
    echo -e "${GREEN}3)${NC} Payment Panel"
    echo -e "${GREEN}4)${NC} Convoy Panel"
    echo -e "${GREEN}5)${NC} Control Panel"
    echo -e "${GREEN}6)${NC} Custom Script (SST)"
    echo -e "${RED}0) Exit${NC}"
    echo -e "${CYAN}-------------------------------------------------------${NC}"

    read -p "Enter your choice [0-6]: " main_choice

    case $main_choice in
        1) panels_menu ;;
        2) dashboard_menu ;;
        3) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pay/upay.sh) ;;
        4) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/convoy/run.sh) ;;
        5) bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/ctrl/run.sh) ;;
        6) bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/sst/main/run.sh) ;;
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
