#!/bin/bash

# ==========================================
#      PufferPanel Auto Installer
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

    # Check for Fedora / RHEL / CentOS (RedHat based)
    if [[ "$OS" == "fedora" || "$LIKE" == *"rhel"* || "$LIKE" == *"fedora"* || "$LIKE" == *"centos"* ]]; then
        PKG_MANAGER="dnf"
        REPO_SCRIPT="script.rpm.sh"
        echo "Detected RedHat/Fedora based system. Using DNF."
    
    # Check for Debian / Ubuntu (Debian based)
    elif [[ "$OS" == "debian" || "$OS" == "ubuntu" || "$LIKE" == *"debian"* || "$LIKE" == *"ubuntu"* ]]; then
        PKG_MANAGER="apt"
        REPO_SCRIPT="script.deb.sh"
        echo "Detected Debian/Ubuntu based system. Using APT."
    
    else
        # Default fallback to APT
        PKG_MANAGER="apt"
        REPO_SCRIPT="script.deb.sh"
        echo "OS not strictly identified. Defaulting to APT."
    fi
}

# Run detection immediately
detect_os

# --- 2. Banner Function ---
show_banner() {
    clear
    # Cyan Color for Art
    echo -e "\033[1;36m"
    echo "   _____ ____  _________    __  ___ __________ "
    echo "  / ___// __ \/ ____/   |  /  |/  / ____/ __ \\"
    echo "  \__ \/ / / / / __/ /| | / /|_/ / __/ / /_/ /"
    echo " ___/ / /_/ / /_/ / ___ |/ /  / / /___/ _, _/ "
    echo "/____/_____/\____/_/  |_/_/  /_/_____/_/ |_|  "
    echo -e "\033[0m"
    
    # Subtitles
    echo -e "\033[1;32m    PUFFERPANEL AUTO INSTALLER - MANAGER     \033[0m"
    echo -e "\033[1;31m             Made By SDGAMER                 \033[0m"
    echo -e "\033[1;34m=============================================\033[0m"
    
    # System Info
    echo -e "Detected OS    : \033[1;33m${OS^}\033[0m"
    echo -e "Package Manager: \033[1;33m${PKG_MANAGER^^}\033[0m"
    echo -e "\033[1;34m=============================================\033[0m"
    
    # Menu Options
    echo "1. Install PufferPanel V1 (Docker)"
    echo "2. Install PufferPanel V2 (Native)"
    echo "3. Start PufferPanel (Docker Only)"
    echo "4. Exit"
    echo -e "\033[1;34m---------------------------------------------\033[0m"
}

# --- 3. Main Loop ---
while true; do
    show_banner
    read -p "Select an option [1-4]: " choice

    case $choice in
        1)
            echo -e "\033[1;34m[INFO] Starting Installation of PufferPanel V1 (Docker)...\033[0m"
            
            # Update System
            sudo $PKG_MANAGER update -y
            sudo $PKG_MANAGER upgrade -y
            
            # 1. Create Directories
            echo "Creating directories..."
            sudo mkdir -p /var/lib/pufferpanel
            
            # 2. Create Docker Volume
            echo "Creating Docker volume..."
            sudo docker volume create pufferpanel-config
            
            # 3. Create Container
            echo "Creating PufferPanel container..."
            sudo docker create --name pufferpanel -p 8080:8080 -p 5657:5657 \
            -v pufferpanel-config:/etc/pufferpanel \
            -v /var/lib/pufferpanel:/var/lib/pufferpanel \
            -v /var/run/docker.sock:/var/run/docker.sock \
            --restart=on-failure pufferpanel/pufferpanel:latest
            
            # 4. Start Container
            echo "Starting container..."
            sudo docker start pufferpanel
            
            # 5. Add User
            echo -e "\033[1;33m[ACTION REQUIRED] Create Admin User below:\033[0m"
            sudo docker exec -it pufferpanel /pufferpanel/pufferpanel user add
            
            echo -e "\033[1;32m[SUCCESS] Installation Finished!\033[0m"
            read -p "Press Enter to return to menu..."
            ;;
        
        2)
            echo -e "\033[1;34m[INFO] Starting Installation of PufferPanel V2 (Native)...\033[0m"
            
            # Update System
            echo "Updating system..."
            sudo $PKG_MANAGER update -y
            
            # Install Dependencies
            echo "Installing dependencies (curl, sudo)..."
            sudo $PKG_MANAGER install -y curl sudo
            
            # Install systemctl if on apt (rarely needed but requested)
            if [[ "$PKG_MANAGER" == "apt" ]]; then
                 sudo apt install -y systemctl
            fi

            # Add Repository (Auto-detects deb vs rpm script)
            echo "Adding PufferPanel Repositories..."
            curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/${REPO_SCRIPT} | sudo bash

            echo "Made By SDGAMER"
            sudo $PKG_MANAGER update -y
            
            # Install Panel
            echo "Installing PufferPanel..."
            sudo $PKG_MANAGER install -y pufferpanel
            
            # Enable Service
            echo "Starting panel on port 8080..."
            sudo systemctl enable --now pufferpanel
            
            # Add User
            echo -e "\033[1;33m[ACTION REQUIRED] Create Admin User below:\033[0m"
            sudo pufferpanel user add
            
            echo -e "\033[1;32m[SUCCESS] Installation Finished! Panel is running.\033[0m"
            read -p "Press Enter to return to menu..."
            ;;
            
        3)
            echo -e "\033[1;34m[INFO] Starting PufferPanel Docker Container...\033[0m"
            sudo docker start pufferpanel
            echo -e "\033[1;32m[SUCCESS] Done.\033[0m"
            read -p "Press Enter to return to menu..."
            ;;
            
        4)
            echo -e "\033[1;31mExiting SDGAMER Installer. Bye!\033[0m"
            exit 0
            ;;
            
        *)
            # Invalid Input Handling
            echo -e "\033[1;31m[ERROR] Invalid Option! Please select 1, 2, 3, or 4.\033[0m"
            sleep 2
            # Loop continues, showing banner again
            ;;
    esac
done
