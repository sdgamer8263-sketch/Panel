#!/bin/bash

# ==========================================
#      PufferPanel Auto Installer & Manager
#           Made By SDGAMER
# ==========================================

# --- 1. OS Detection Function ---
detect_os() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        LIKE=$ID_LIKE
    else
        OS="unknown"
        LIKE="unknown"
    fi

    # Check for Fedora / RHEL / CentOS
    if [[ "$OS" == "fedora" || "$LIKE" == *"rhel"* || "$LIKE" == *"fedora"* || "$LIKE" == *"centos"* ]]; then
        PKG_MANAGER="dnf"
        REPO_SCRIPT="script.rpm.sh"
    # Check for Debian / Ubuntu
    elif [[ "$OS" == "debian" || "$OS" == "ubuntu" || "$LIKE" == *"debian"* || "$LIKE" == *"ubuntu"* ]]; then
        PKG_MANAGER="apt"
        REPO_SCRIPT="script.deb.sh"
    else
        PKG_MANAGER="apt"
        REPO_SCRIPT="script.deb.sh"
    fi
}

# Run detection immediately
detect_os

# --- 2. Banner Function ---
show_banner() {
    clear
    echo -e "\033[1;36m"
    echo "   _____ ____  _________    __  ___ __________ "
    echo "  / ___// __ \/ ____/   |  /  |/  / ____/ __ \\"
    echo "  \__ \/ / / / / __/ /| | / /|_/ / __/ / /_/ /"
    echo " ___/ / /_/ / /_/ / ___ |/ /  / / /___/ _, _/ "
    echo "/____/_____/\____/_/  |_/_/  /_/_____/_/ |_|  "
    echo -e "\033[0m"
    echo -e "\033[1;32m    PUFFERPANEL MANAGER (INSTALL/UNINSTALL)  \033[0m"
    echo -e "\033[1;31m             Made By SDGAMER                 \033[0m"
    echo -e "\033[1;34m=============================================\033[0m"
    echo -e "OS: \033[1;33m${OS^}\033[0m | Manager: \033[1;33m${PKG_MANAGER^^}\033[0m"
    echo -e "\033[1;34m=============================================\033[0m"
}

# --- 3. Sub-Menu Functions ---

# Function for V1 (Docker)
menu_v1() {
    while true; do
        show_banner
        echo -e "\033[1;35m[ PufferPanel V1 - Docker Menu ]\033[0m"
        echo "1. Install V1 (Docker)"
        echo "2. Uninstall V1 (Docker)"
        echo "3. Back to Main Menu"
        echo -e "\033[1;34m---------------------------------------------\033[0m"
        read -p "Select option [1-3]: " v1_choice

        case $v1_choice in
            1)
                echo -e "\033[1;34m[INFO] Installing PufferPanel V1...\033[0m"
                sudo $PKG_MANAGER update -y
                sudo mkdir -p /var/lib/pufferpanel
                sudo docker volume create pufferpanel-config
                sudo docker create --name pufferpanel -p 8080:8080 -p 5657:5657 \
                -v pufferpanel-config:/etc/pufferpanel \
                -v /var/lib/pufferpanel:/var/lib/pufferpanel \
                -v /var/run/docker.sock:/var/run/docker.sock \
                --restart=on-failure pufferpanel/pufferpanel:latest
                sudo docker start pufferpanel
                echo -e "\033[1;33mCreate Admin User below:\033[0m"
                sudo docker exec -it pufferpanel /pufferpanel/pufferpanel user add
                read -p "Done. Press Enter..."
                ;;
            2)
                echo -e "\033[1;31m[WARNING] Uninstalling PufferPanel V1...\033[0m"
                sudo docker stop pufferpanel
                sudo docker rm pufferpanel
                sudo docker volume rm pufferpanel-config
                sudo rm -rf /var/lib/pufferpanel
                echo -e "\033[1;32m[SUCCESS] Uninstalled Successfully.\033[0m"
                read -p "Press Enter..."
                ;;
            3)
                return ;; # Go back to main menu
            *)
                echo -e "\033[1;31mInvalid Option! Try again.\033[0m"
                sleep 1
                ;;
        esac
    done
}

# Function for V2 (Native)
menu_v2() {
    while true; do
        show_banner
        echo -e "\033[1;35m[ PufferPanel V2 - Native Menu ]\033[0m"
        echo "1. Install V2 (Native)"
        echo "2. Uninstall V2 (Native)"
        echo "3. Back to Main Menu"
        echo -e "\033[1;34m---------------------------------------------\033[0m"
        read -p "Select option [1-3]: " v2_choice

        case $v2_choice in
            1)
                echo -e "\033[1;34m[INFO] Installing PufferPanel V2...\033[0m"
                sudo $PKG_MANAGER update -y
                sudo $PKG_MANAGER install -y curl sudo
                curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/${REPO_SCRIPT} | sudo bash
                sudo $PKG_MANAGER update -y
                sudo $PKG_MANAGER install -y pufferpanel
                sudo systemctl enable --now pufferpanel
                echo -e "\033[1;33mCreate Admin User below:\033[0m"
                sudo pufferpanel user add
                read -p "Done. Press Enter..."
                ;;
            2)
                echo -e "\033[1;31m[WARNING] Uninstalling PufferPanel V2...\033[0m"
                sudo systemctl stop pufferpanel
                sudo systemctl disable pufferpanel
                sudo $PKG_MANAGER remove -y pufferpanel
                sudo rm -rf /var/lib/pufferpanel
                sudo rm -rf /etc/pufferpanel
                echo -e "\033[1;32m[SUCCESS] Uninstalled Successfully.\033[0m"
                read -p "Press Enter..."
                ;;
            3)
                return ;; # Go back to main menu
            *)
                echo -e "\033[1;31mInvalid Option! Try again.\033[0m"
                sleep 1
                ;;
        esac
    done
}

# --- 4. Main Menu Loop ---
while true; do
    show_banner
    echo "1. PufferPanel V1 (Docker)"
    echo "2. PufferPanel V2 (Native)"
    echo "3. Exit"
    echo -e "\033[1;34m---------------------------------------------\033[0m"
    read -p "Select Version [1-3]: " choice

    case $choice in
        1)
            menu_v1
            ;;
        2)
            menu_v2
            ;;
        3)
            echo "Exiting SDGAMER Installer."
            exit 0
            ;;
        *)
            echo -e "\033[1;31mInvalid Option! Please select 1, 2, or 3.\033[0m"
            sleep 1
            ;;
    esac
done
