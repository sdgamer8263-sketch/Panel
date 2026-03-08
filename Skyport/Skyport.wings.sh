!/bin/bash

# =========================================================
#                 SDGAMER CONFIGURATION
# =========================================================

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Function: Professional SDGAMER Banner
function show_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
   _____ ____  _____          __  __ ______ _____  
  / ____|  _ \|  __ \   /\   |  \/  |  ____|  __ \ 
 | (___ | | | | |  \/  /  \  | \  / | |__  | |__) |
  \___ \| | | | | __  / /\ \ | |\/| |  __| |  _  / 
  ____) | |_| | |_\ \/ ____ \| |  | | |____| | \ \ 
 |_____/|____/ \____/_/    \_\_|  |_|______|_|  \_\
                                                       
EOF
    echo -e "${BLUE}    >>> POWERED BY SDGAMER HOSTING SOLUTIONS <<<    ${RESET}"
    echo -e "${YELLOW} ================================================== ${RESET}"
    echo ""
}

# Update package list and install dependencies
sudo apt update
sudo apt install -y curl software-properties-common
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install nodejs -y 
sudo apt install git -y

# Wings

git clone https://github.com/achul123/skyportd.git
cd skyportd 
npm install

echo_message "* cd skyportd"

echo_message "* paste your configure code"

echo_message "* pm2 start ."


