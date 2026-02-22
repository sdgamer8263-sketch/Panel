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

# Redirect Function for Exit
exit_and_redirect() {
    echo -e "\n${MAGENTA}👋 Management task finished.${NC}"
    echo -e "${CYAN}Press ${BOLD}${WHITE}Enter${NC}${CYAN} to return to SDGAMER Panel...${NC}"
    read -p "" 
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
    exit 0
}

clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}${MAGENTA}🔰 SDGAMER DASHBOARD MANAGER${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${GREEN}1️⃣${NC}  Install System"
echo -e "${RED}2️⃣${NC}  Uninstall System"
echo ""
read -p "👉 Choose option [1-2]: " ACTION

############################################
# INSTALL
############################################
if [ "$ACTION" == "1" ]; then
    echo ""
    echo -e "${GREEN}🚀 Initializing SDGAMER Installation...${NC}"
    # Link remains for functionality, branding updated in script flow
    bash <(curl -s https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/panel/Dashboard-v4.sh)
    echo -e "${CYAN}Installation process completed ✨${NC}"
    exit_and_redirect
fi

############################################
# UNINSTALL — FULL CLEANUP
############################################
if [ "$ACTION" == "2" ]; then

    echo ""
    echo -e "${RED}🧹 Uninstalling System Components...${NC}"
    sleep 1

    # REMOVE PANEL FILES
    rm -rf /var/www/mythicaldash-v3

    # REMOVE NGINX CONFIG
    rm -f /etc/nginx/sites-enabled/MythicalDashRemastered.conf
    rm -f /etc/nginx/sites-available/MythicalDashRemastered.conf

    # REMOVE SSL CERTS
    rm -rf /etc/certs/MythicalDash-4

    # REMOVE CRON JOBS
    crontab -l 2>/dev/null \
    | grep -v "/var/www/mythicaldash-v3/backend/storage/cron/runner.bash" \
    | grep -v "/var/www/mythicaldash-v3/backend/storage/cron/runner.php" \
    | crontab -

    # DROP DATABASE & USER
    mariadb -e "DROP DATABASE IF EXISTS mythicaldash_remastered;"
    mariadb -e "DROP USER IF EXISTS 'mythicaldash_remastered'@'127.0.0.1';"
    mariadb -e "FLUSH PRIVILEGES;"

    echo ""
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✅ System fully removed by SDGAMER${NC}"
    echo -e "${YELLOW}Server is now clean. ⚖️${NC}"
    echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit_and_redirect
fi

echo -e "${RED}❌ Invalid option selected${NC}"
exit_and_redirect
