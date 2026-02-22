#!/bin/bash

# Colors for UI - Enhanced Neon Theme
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m' 
BOLD='\033[1m'

show_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}    __  __       _   _               _     _____       ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}   |  \/  |     | | | |             | |   |  __ \      ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}   | \  / |_   _| |_| |__   ___   __| |___| |  | |     ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}   | |\/| | | | | __| '_ \ / _ \ / _\` / __| |  | |     ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}   | |  | | |_| | |_| | | | (_) | (_| \__ \ |__| |     ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${MAGENTA}   |_|  |_|\__,_|\__|_| |_|\___/ \__,_|___/_____/      ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}${BOLD}${WHITE}         B Y    S D G A M E R           ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
}

while true; do
    show_header
    
    # Modern Menu UI
    echo -e "  ${WHITE}Main Menu:${NC}"
    echo -e "  ${CYAN}┌──────────────────────────────────────────────────────┐${NC}"
    echo -e "  ${CYAN}│${NC}  ${GREEN}[1]${NC} ${BOLD}INSTALL SYSTEM${NC}      ${WHITE}Deploy a fresh instance${NC}   ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${YELLOW}[2]${NC} ${BOLD}UPDATE SYSTEM${NC}       ${WHITE}Pull latest changes   ${NC}   ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${RED}[3]${NC} ${BOLD}UNINSTALL${NC}           ${WHITE}Wipe all data         ${NC}   ${CYAN}│${NC}"
    echo -e "  ${CYAN}│${NC}  ${MAGENTA}[4]${NC} ${BOLD}SWITCH PANEL${NC}        ${WHITE}Run External Script   ${NC}   ${CYAN}│${NC}"
    echo -e "  ${CYAN}├──────────────────────────────────────────────────────┤${NC}"
    echo -e "  ${CYAN}│${NC}  ${BOLD}v3.2.3${NC} | ${BLUE}Status: Online${NC} | ${CYAN}Powered by: SDGAMER    │${NC}"
    echo -e "  ${CYAN}└──────────────────────────────────────────────────────┘${NC}"
    echo ""
    
    read -p "$(echo -e "  ${BOLD}${YELLOW}Selection › ${NC}")" option

    case $option in
        1)
            echo -e "\n${GREEN}🚀 INITIALIZING INSTALLATION...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/panel/Dashboard-v3.sh)
            ;;
            
        2)
            echo -e "\n${YELLOW}🔄 CHECKING FOR UPDATES...${NC}"
            if [ ! -d "/var/www/mythicaldash" ]; then
                echo -e "${RED}❌ Error: /var/www/mythicaldash not found!${NC}"
                read -p "Press Enter to return..."
                continue
            fi
            
            cd /var/www/mythicaldash
            echo -e "${BLUE}»${NC} Fetching MythicalDash.zip..."
            curl -Lo MythicalDash.zip https://github.com/MythicalLTD/MythicalDash/releases/download/3.2.3/MythicalDash.zip
            unzip -o MythicalDash.zip -d /var/www/mythicaldash
            dos2unix arch.bash
            sudo bash arch.bash
            composer install --no-dev --optimize-autoloader
            ./MythicalDash -migrate
            chown -R www-data:www-data /var/www/mythicaldash/*
            echo -e "${GREEN}✅ System updated successfully by SDGAMER!${NC}"
            ;;
            
        3)
            echo -e "\n${RED}⚠️  DANGER ZONE: UNINSTALLATION${NC}"
            read -p "$(echo -e "${RED}Confirm complete wipe? (y/N):${NC} ")" confirm
            if [[ $confirm == "y" || $confirm == "Y" ]]; then
                echo -e "${BLUE}»${NC} Removing Database..."
                mariadb -u root -p -e "DROP DATABASE IF EXISTS mythicaldash; DROP USER IF EXISTS 'mythicaldash'@'127.0.0.1'; FLUSH PRIVILEGES;"
                echo -e "${BLUE}»${NC} Cleaning files & configs..."
                rm -rf /var/www/mythicaldash
                sudo crontab -l | grep -v 'php /var/www/mythicaldash/crons/server.php' | sudo crontab - || true
                rm /etc/nginx/sites-available/MythicalDash.conf /etc/nginx/sites-enabled/MythicalDash.conf 2>/dev/null
                systemctl restart nginx
                echo -e "${GREEN}✅ System purged.${NC}"
            else
                echo -e "${YELLOW}Cancelled.${NC}"
            fi
            ;;
            
        4)
            echo -e "\n${MAGENTA}🔄 REDIRECTING TO SDGAMER PANEL...${NC}"
            echo -e "${CYAN}Executing: bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)${NC}\n"
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
            exit 0
            ;;
            
        *)
            echo -e "\n${RED}❌ Invalid choice. Try 1-4.${NC}"
            ;;
    esac

    echo ""
    read -p "$(echo -e "${CYAN}Press ${BOLD}Enter${NC}${CYAN} to continue...${NC}")" dummy
done
