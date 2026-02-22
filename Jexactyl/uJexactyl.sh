#!/bin/bash

# Colors for UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# ASCII Art for Jexactyl + SDGAMER
show_header() {
    clear
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ██╗███████╗██╗  ██╗ █████╗  ██████╗ ████████╗██╗   ██╗ ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ██║██╔════╝╚██╗██╔╝██╔══██╗██╔════╝ ╚══██╔══╝╚██╗ ██╔╝ ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ██║█████╗   ╚███╔╝ ███████║██║  ███╗   ██║    ╚████╔╝  ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ██║██╔══╝   ██╔██╗ ██╔══██║██║   ██║   ██║     ╚██╔╝   ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ██║███████╗██╔╝ ██╗██║  ██║╚██████╔╝   ██║      ██║    ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}║${NC}${PURPLE}   ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝    ╚═╝      ╚═╝    ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${NC}${BOLD}${YELLOW}          S D G A M E R   X   J E X A C T Y L            ${NC}${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════╝${NC}"
}

while true; do
    show_header
    
    # Modernized Menu Options
    echo -e "  ${BOLD}${WHITE}Manage your Panel:${NC}"
    echo -e "  ${PURPLE}┌──────────────────────────────────────────────┐${NC}"
    echo -e "  ${PURPLE}│${NC} ${GREEN}📦${NC} ${BOLD}1.${NC} Install Jexactyl      ${CYAN}Fresh Setup${NC}    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC} ${RED}🗑️${NC} ${BOLD}2.${NC} Uninstall System      ${CYAN}Wipe Data  ${NC}    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC} ${YELLOW}🔄${NC} ${BOLD}3.${NC} Update Panel          ${CYAN}Latest Ver ${NC}    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}│${NC} ${BLUE}🚀${NC} ${BOLD}4.${NC} Switch to SDGAMER     ${CYAN}Run Script ${NC}    ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}├──────────────────────────────────────────────┤${NC}"
    echo -e "  ${PURPLE}│${NC} ${CYAN}Developed by: SDGAMER | Powered by: Jexactyl  ${PURPLE}│${NC}"
    echo -e "  ${PURPLE}└──────────────────────────────────────────────┘${NC}"
    echo ""
    
    read -p "$(echo -e "  ${BOLD}${YELLOW}Selection › ${NC}")" choice

    case "$choice" in
        1)
            echo -e "\n${GREEN}🚀 INITIALIZING INSTALLATION...${NC}"
            bash <(curl -s https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/panel/Jexpanel.sh)
            echo -e "\n${GREEN}✅ Installation process completed!${NC}"
            ;;
            
        2)
            echo -e "\n${RED}⚠️  DANGER ZONE: UNINSTALLATION${NC}"
            read -p "$(echo -e "${RED}Are you sure you want to wipe everything? (y/N):${NC} ")" confirm
            
            if [[ $confirm == "y" || $confirm == "Y" ]]; then
                echo -e "\n${RED}🗑️  Purging system files...${NC}"
                systemctl stop jxctl.service 2>/dev/null
                systemctl disable jxctl.service 2>/dev/null
                rm -f /etc/systemd/system/jxctl.service 2>/dev/null
                systemctl daemon-reload 2>/dev/null
                rm -f /etc/nginx/sites-available/jexactyl.conf /etc/nginx/sites-enabled/jexactyl.conf 2>/dev/null
                nginx -s reload 2>/dev/null
                mysql -u root -p -e "DROP DATABASE IF EXISTS jexactyldb; DROP USER IF EXISTS 'jexactyluser'@'127.0.0.1'; FLUSH PRIVILEGES;" 2>/dev/null
                sudo crontab -l | grep -v 'php /var/www/jexactyl/artisan schedule:run' | sudo crontab - || true
                rm -rf /var/www/jexactyl 2>/dev/null
                echo -e "${GREEN}✅ System is now clean.${NC}"
            else
                echo -e "${YELLOW}❌ Uninstall cancelled.${NC}"
            fi
            ;;
            
        3)
            echo -e "\n${YELLOW}🔄 CHECKING FOR UPDATES...${NC}"
            if [ ! -d "/var/www/jexactyl" ]; then
                echo -e "${RED}❌ Error: Jexactyl directory not found!${NC}"
                read -p "Press Enter to continue..."
                continue
            fi
            cd /var/www/jexactyl
            php artisan down
            curl -Lo panel.tar.gz https://github.com/jexactyl/jexactyl/releases/download/v4.0.0-rc2/panel.tar.gz
            tar -xzvf panel.tar.gz
            chmod -R 755 storage/* bootstrap/cache/
            COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
            php artisan optimize:clear
            php artisan migrate --seed --force
            chown -R www-data:www-data /var/www/jexactyl/
            php artisan up
            echo -e "${GREEN}✅ Update successfully applied!${NC}"
            ;;
            
        4)
            echo -e "\n${MAGENTA}🔄 REDIRECTING TO SDGAMER PANEL...${NC}"
            echo -e "${CYAN}Executing external script...${NC}\n"
            # Running your requested script
            bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
            exit 0
            ;;
            
        *)
            echo -e "\n${RED}❌ Invalid selection. Please use 1-4.${NC}"
            ;;
    esac

    echo ""
    read -p "$(echo -e "${CYAN}Press ${BOLD}Enter${NC}${CYAN} to return to menu...${NC}")" dummy
done
