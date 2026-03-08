#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# ASCII Art Function
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "   _____ ____   _____    _    __  __  ____ ____  "
    echo "  / ____|  _ \ / ____|  / \  |  \/  ||  __|  _ \ "
    echo " | (___ | | | | |  __  / _ \ | \  / || |__ | |_) |"
    echo "  \___ \| | | | | |_ |/ ___ \| |\/| ||  __||  _ < "
    echo "  ____) | |_| | |__| / /   \ \ |  | || |___| | \ \ "
    echo " |_____/|____/ \_____/_/   \_\_|  |_||_____|_|  \_\ "
    echo -e "${NC}"
    echo -e "${BLUE}    Hydra Panel + Daemon Installer (SDGAMER)    ${NC}"
    echo "----------------------------------------------------"
}

# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}Please run this script as root.${NC}"
  exit 1
fi

# Function to Detect OS and Install Dependencies
install_dependencies() {
    # Load OS information
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$ID
        LIKE=$ID_LIKE
    else
        echo -e "${RED}OS cannot be detected. Exiting.${NC}"
        return 1
    fi

    echo -e "${YELLOW}* Detected OS: $PRETTY_NAME${NC}"

    if [[ "$OS" == "ubuntu" || "$OS" == "debian" || "$LIKE" == *"debian"* ]]; then
        # --- UBUNTU / DEBIAN LOGIC (APT) ---
        echo -e "${CYAN}* Using APT package manager...${NC}"
        sudo apt update
        sudo apt install -y curl software-properties-common git
        
        # Install Node.js 20
        curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
        sudo apt-get install nodejs -y 

    elif [[ "$OS" == "fedora" || "$OS" == "centos" || "$OS" == "rhel" || "$LIKE" == *"fedora"* ]]; then
        # --- FEDORA / RHEL LOGIC (DNF) ---
        echo -e "${CYAN}* Using DNF package manager...${NC}"
        sudo dnf update -y
        sudo dnf install -y curl git
        
        # Install Node.js 20 (RPM version)
        curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -
        sudo dnf install -y nodejs

    else
        echo -e "${RED}* Unsupported OS. Please use Ubuntu, Debian, or Fedora.${NC}"
        return 1
    fi
}

# Function to Install Hydra Panel (Modified as per request)
install_panel() {
    echo -e "${YELLOW}* Starting Panel Installation...${NC}"
    
    # 1. Install Dependencies based on OS
    install_dependencies
    
    if [ -d "oversee-fixed" ]; then
        echo -e "${RED}Error: 'oversee-fixed' directory already exists.${NC}"
        read -p "Press Enter to return..."
        return
    fi

    echo -e "${GREEN}* Installing Files (Cloning oversee-fixed)...${NC}"

    # 2. Run the specific command chain requested
    # Note: Using 'set -e' logic via && to ensure it stops if a step fails
    git clone https://github.com/draco-labes/oversee-fixed.git && \
    cd oversee-fixed && \
    npm install && \
    npm run seed && \
    npm run createUser && \
    
    echo -e "${GREEN}* Installed Files${NC}"
    echo -e "${CYAN}* Starting Skyport (Hydra)...${NC}"
    echo -e "${GREEN}* Skyport Installed and Started on Port 3001${NC}"
    
    node .
    
    # If the user stops the node process with Ctrl+C, they return here
    read -p "Press Enter to return to menu..."
}

# Function to Install Hydra Daemon (Node)
install_node() {
    echo -e "${YELLOW}* Starting Daemon (Node) Installation...${NC}"
    install_dependencies

    if [ -d "HydraDAEMON" ]; then
        echo -e "${RED}Error: 'HydraDAEMON' directory already exists.${NC}"
        read -p "Press Enter to return..."
        return
    fi

    git clone https://github.com/hydren-dev/HydraDAEMON
    
    if [ -d "HydraDAEMON" ]; then
        cd HydraDAEMON
        npm install
        
        echo -e "${GREEN}* Dependencies Installed.${NC}"
        echo -e "${YELLOW}-----------------------------------------------------"
        echo -e "PLEASE PASTE YOUR CONFIGURATION COMMAND NOW."
        echo -e "(Copy the command from your Panel and paste it here, then press Enter)"
        echo -e "-----------------------------------------------------${NC}"
        
        # Allowing user to run the config command
        read -p "Command > " config_cmd
        eval "$config_cmd"
        
        echo -e "${CYAN}* Starting Node...${NC}"
        node .
    else
        echo -e "${RED}Failed to clone HydraDAEMON.${NC}"
    fi
    read -p "Press Enter to return to menu..."
}

# Function to Start Services (Again Start)
start_services() {
    while true; do
        clear
        echo -e "${BLUE}=== Start Services ===${NC}"
        echo "1. Start Panel (Dash)"
        echo "2. Start Node (Daemon)"
        echo "3. Back to Main Menu"
        echo ""
        echo -n "Select what to start: "
        read start_choice

        case $start_choice in
            1)
                if [ -d "oversee-fixed" ]; then
                    cd oversee-fixed
                    echo -e "${GREEN}* Starting Panel from 'oversee-fixed'...${NC}"
                    node .
                elif [ -d "panel" ]; then
                    cd panel
                    echo -e "${GREEN}* Starting Panel from 'panel'...${NC}"
                    node .
                else
                    echo -e "${RED}Error: Neither 'oversee-fixed' nor 'panel' folder found.${NC}"
                    read -p "Press Enter to continue..."
                fi
                ;;
            2)
                if [ -d "HydraDAEMON" ]; then
                    cd HydraDAEMON
                    echo -e "${GREEN}* Starting Daemon...${NC}"
                    node .
                else
                    echo -e "${RED}Error: 'HydraDAEMON' folder not found.${NC}"
                    read -p "Press Enter to continue..."
                fi
                ;;
            3)
                return
                ;;
            *)
                echo -e "${RED}Invalid Option.${NC}"
                sleep 1
                ;;
        esac
    done
}

# Function to Uninstall
uninstall_all() {
    echo -e "${YELLOW}* Uninstalling...${NC}"
    
    if [ -d "panel" ]; then
        rm -rf panel
        echo -e "${GREEN}* Panel (Old) removed.${NC}"
    fi
    
    if [ -d "oversee-fixed" ]; then
        rm -rf oversee-fixed
        echo -e "${GREEN}* Oversee-fixed (New Panel) removed.${NC}"
    fi

    if [ -d "HydraDAEMON" ]; then
        rm -rf HydraDAEMON
        echo -e "${GREEN}* HydraDAEMON removed.${NC}"
    fi
    
    echo -e "${CYAN}Uninstall Complete.${NC}"
    read -p "Press Enter to return to menu..."
}

# Main Menu Loop
while true; do
    show_banner
    echo -e "${GREEN}1.${NC} Install Hydra Panel + Dash (Oversee-Fixed)"
    echo -e "${GREEN}2.${NC} Install Node (HydraDAEMON)"
    echo -e "${CYAN}3.${NC} Again Start (Start Panel/Node)"
    echo -e "${RED}4.${NC} Uninstall All"
    echo -e "${YELLOW}5.${NC} Exit"
    echo ""
    echo -n "Select an option: "
    read choice

    case $choice in
        1)
            install_panel
            ;;
        2)
            install_node
            ;;
        3)
            start_services
            ;;
        4)
            uninstall_all
            ;;
        5)
            echo -e "${CYAN}Exiting... Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid Input. Please try again.${NC}"
            sleep 1.5
            ;;
    esac
done
