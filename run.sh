#!/bin/bash

# Banner Section
echo "-------------------------------------------------------"
echo "  ____  ____   ____    _    __  __ _____ ____  "
echo " / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ "
echo " \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |"
echo "  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < "
echo " |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\\"
echo "-------------------------------------------------------"
echo "             WELCOME TO SDGAMER INSTALLER              "
echo "-------------------------------------------------------"

# Main Menu
echo "Select an option to install:"
echo "1) Control Panel"
echo "2) Mythical Dash"
echo "3) Pterodactyl Panel"
echo "4) Jexactyl"
echo "5) Jexapanel"
echo "6) Payment Panel"
echo "7) Reviactyl"
echo "8) Feather Panel"
echo "9) Feather Panel (Auto Install)"
echo "0) Exit"
echo "-------------------------------------------------------"

read -p "Enter your choice [0-9]: " main_choice

case $main_choice in
    1)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/ctrl/uctrl.sh)
        ;;
    2)
        echo "-------------------------------------------------------"
        echo "Mythical Dash Sub-Options:"
        echo "A) Mythical Dash Version - 3.0"
        echo "B) Mythical Dash Version - 4.0"
        read -p "Select version [A or B]: " dash_choice
        if [[ "$dash_choice" == "A" || "$dash_choice" == "a" ]]; then
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Dashv3/udashv3.sh)
        elif [[ "$dash_choice" == "B" || "$dash_choice" == "b" ]]; then
            bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/dashv4/udashv4.sh)
        else
            echo "Invalid option selected."
        fi
        ;;
    3)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pterodactyl/upterodactyl.sh)
        ;;
    4)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexactyl/uJexactyl.sh)
        ;;
    5)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/Jexapanel/Jp.sh)
        ;;
    6)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/pay/upay.sh)
        ;;
    7)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/rev/urev.sh)
        ;;
    8)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/ufea.sh)
        ;;
    9)
        bash <(curl -s https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/fea/fea.sh)
        ;;
    0)
        echo "Exiting... Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid selection. Please run the script again."
        ;;
esac
