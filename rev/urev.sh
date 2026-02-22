#!/bin/bash
# ====================================================
#      REVIACTYL INSTALL / USER / UPDATE / REMOVE
#             Powered by SDGAMER 2026
# ====================================================

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
NC="\033[0m"
BOLD="\033[1m"

# Redirect Function for Exit
exit_and_redirect() {
    echo -e "\n${MAGENTA}👋 Management task finished.${NC}"
    echo -e "${CYAN}Press ${BOLD}Enter${NC}${CYAN} to return to SDGAMER Panel...${NC}"
    read -p "" 
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
    exit 0
}

# ================== INSTALL FUNCTION ==================
install_ptero() {
    clear
    echo -e "${CYAN}"
    echo "┌──────────────────────────────────────────────┐"
    echo "│        🚀 SDGAMER reviactyl Install          │"
    echo "└──────────────────────────────────────────────┘${NC}"
    # Link remains for functionality, branding updated in flow
    bash <(curl -s https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/panel/tool/reviactyl.sh)
    echo -e "${GREEN}✔ Installation Complete${NC}"
    read -p "Press Enter to return..."
}

# ================== CREATE USER ==================
create_user() {
    clear
    echo -e "${CYAN}"
    echo "┌──────────────────────────────────────────────┐"
    echo "│        👤 Create SDGAMER Panel User           │"
    echo "└──────────────────────────────────────────────┘${NC}"

    if [ ! -d /var/www/reviactyl ]; then
        echo -e "${RED}❌ Panel not installed!${NC}"
        read -p "Press Enter to return..."
        return
    fi

    cd /var/www/reviactyl || exit
    php artisan p:user:make

    echo -e "${GREEN}✔ User created successfully${NC}"
    read -p "Press Enter to return..."
}

# ================= PANEL UNINSTALL =================
uninstall_panel() {
    echo ">>> Stopping Panel service..."
    systemctl stop reviq.service 2>/dev/null || true
    systemctl disable reviq.service 2>/dev/null || true
    rm -f /etc/systemd/system/reviq.service
    systemctl daemon-reload

    echo ">>> Removing cronjob..."
    crontab -l | grep -v 'php /var/www/reviactyl/artisan schedule:run' | crontab - || true

    echo ">>> Removing files..."
    rm -rf /var/www/reviactyl

    echo ">>> Dropping database..."
    mysql -u root -e "DROP DATABASE IF EXISTS reviactyl;"
    mysql -u root -e "DROP USER IF EXISTS 'reviactyl'@'127.0.0.1';"
    mysql -u root -e "FLUSH PRIVILEGES;"

    echo ">>> Cleaning nginx..."
    rm -f /etc/nginx/sites-enabled/reviactyl.conf
    rm -f /etc/nginx/sites-available/reviactyl.conf
    systemctl reload nginx || true

    echo -e "${GREEN}✅ Panel removed by SDGAMER.${NC}"
}

uninstall_ptero() {
    clear
    echo -e "${CYAN}"
    echo "┌──────────────────────────────────────────────┐"
    echo "│        🧹 reviactyl Uninstallation          │"
    echo "└──────────────────────────────────────────────┘${NC}"
    uninstall_panel
    echo -e "${GREEN}✔ Panel Uninstalled (Wings untouched)${NC}"
    read -p "Press Enter to return..."
}

# ================= UPDATE FUNCTIONS =================
reset_panel() {
    clear
    echo -e "${YELLOW}"
    echo "═══════════════════════════════════════════════"
    echo "        ⚡ SDGAMER PANEL RESET ⚡               "
    echo "═══════════════════════════════════════════════${NC}"

    cd /var/www/reviactyl || {
        echo -e "${RED}❌ Panel not found!${NC}"
        read
        return
    }

    php artisan down
    php artisan p:upgrade
    php artisan up
    echo -e "${GREEN}🎉 Panel Reset Successfully by SDGAMER${NC}"
    read -p "Press Enter to return..."
}

Migrating() {
    clear
    echo -e "${YELLOW}"
    echo "═══════════════════════════════════════════════"
    echo "        ⚡ Migration to Reviactyl ⚡            "
    echo "═══════════════════════════════════════════════${NC}"

      cd /var/www/pterodactyl || {
        echo -e "${RED}❌ Panel not found!${NC}"
        read
        return
    }

    php artisan down
    cd /var/www/pterodactyl
    rm -rf *
    curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/
    COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
    php artisan migrate --seed --force
    chown -R www-data:www-data /var/www/pterodactyl/*
    sudo systemctl enable --now pteroq.service
    php artisan up
    echo -e "${GREEN}🎉 Migration completed by SDGAMER${NC}"
    read -p "Press Enter to return..."
}

update() {
    clear
    echo -e "${YELLOW}"
    echo "═══════════════════════════════════════════════"
    echo "        ⚡ SDGAMER PANEL UPDATE ⚡              "
    echo "═══════════════════════════════════════════════${NC}"

      cd /var/www/reviactyl || {
        echo -e "${RED}❌ Panel not found!${NC}"
        read
        return
    }

    php artisan down
    cd /var/www/reviactyl
    curl -Lo panel.tar.gz https://github.com/reviactyl/panel/releases/latest/download/panel.tar.gz
    tar -xzvf panel.tar.gz
    chmod -R 755 storage/* bootstrap/cache/
    COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader
    php artisan migrate --seed --force
    chown -R www-data:www-data /var/www/reviactyl/*
    sudo systemctl enable --now reviq.service
    php artisan up
    echo -e "${GREEN}🎉 Panel Updated Successfully by SDGAMER${NC}"
    read -p "Press Enter to return..."
}

# ===================== MENU =====================
while true; do
clear
echo -e "${YELLOW}"
echo "╔═══════════════════════════════════════════════╗"
echo "║        🐲 reviactyl CONTROL CENTER           ║"
echo "║             Powered by SDGAMER                 ║"
echo "╠═══════════════════════════════════════════════╣"
echo -e "║ ${GREEN}1) Install Panel${NC}"
echo -e "║ ${CYAN}2) Create Panel User${NC}"
echo -e "║ ${YELLOW}3) Reset Panel${NC}"
echo -e "║ ${RED}4) Uninstall Panel${NC}"
echo -e "║ ${GREEN}5) Migrating Panel${NC}"
echo -e "║ ${GREEN}6) Update Panel${NC}"
echo -e "║ 7) Exit & Switch Panel"
echo "╚═══════════════════════════════════════════════╝"
echo -ne "${CYAN}Select Option → ${NC}"
read choice

case $choice in
    1) install_ptero ;;
    2) create_user ;;
    3) reset_panel ;;
    4) uninstall_ptero ;;
    5) Migrating ;;
    6) update ;;
    7) exit_and_redirect ;;
    *) echo -e "${RED}Invalid option...${NC}"; sleep 1 ;;
esac
done
