#!/bin/bash

# SDGAMER BANNER
echo -e "\e[36m"
cat << "EOF"
  ____  ____   ____    _    __  __ _____ ____  
 / ___||  _ \ / ___|  / \  |  \/  | ____|  _ \ 
 \___ \| | | | |  _  / _ \ | |\/| |  _| | |_) |
  ___) | |_| | |_| |/ ___ \| |  | | |___|  _ < 
 |____/|____/ \____/_/   \_\_|  |_|_____|_| \_\
                                               
EOF
echo -e "\e[0m"
echo "======================================================="
echo "       🎮 SDGAMER HELIACTYL v12 AUTO-INSTALLER 🎮      "
echo "======================================================="
echo ""

# 1. User Inputs (Interactive Prompts)
echo -e "\e[33mPlease provide the following details to configure Heliactyl:\e[0m"

read -p "Enter your Dashboard Domain (e.g., https://dashboard.yourdomain.com): " DASH_DOMAIN
read -p "Enter your Pterodactyl Panel API Key (ptlc_...): " PANEL_API
read -p "Enter your Discord Client ID: " DISCORD_CLIENT_ID
read -p "Enter your Discord Client Secret: " DISCORD_CLIENT_SECRET
read -p "Enter your Discord Bot Token: " DISCORD_BOT_TOKEN
read -p "Enter your Discord Server ID: " DISCORD_SERVER_ID

echo ""
echo "======================================================="
echo "Configuration saved! Starting installation in 3 seconds..."
echo "======================================================="
sleep 3

# 2. Update system and install dependencies
echo "[1/5] Installing build dependencies & Nginx..."
sudo apt-get update -y
sudo apt-get install -y curl git libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev build-essential ufw nginx certbot

# 3. Install Node.js 16 via NVM
echo "[2/5] Installing Node.js v16..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install 16
nvm use 16

# 4. Clone Heliactyl
echo "[3/5] Downloading Heliactyl v12..."
sudo mkdir -p /var/www/heliactyl
sudo chown -R $USER:$USER /var/www/heliactyl
git clone https://github.com/OpenHeliactyl/Heliactyl.git /var/www/heliactyl

# 5. Generate settings.json based on User Input
echo "[4/5] Generating settings.json file..."
cat << EOF > /var/www/heliactyl/settings.json
{
    "panelinfo": {
        "domain": "${DASH_DOMAIN}",
        "apikey": "${PANEL_API}",
        "port": 2502
    },
    "discord": {
        "clientid": "${DISCORD_CLIENT_ID}",
        "secret": "${DISCORD_CLIENT_SECRET}",
        "callback": "${DASH_DOMAIN}/callback",
        "bottoken": "${DISCORD_BOT_TOKEN}",
        "serverid": "${DISCORD_SERVER_ID}"
    },
    "database": {
        "host": "localhost",
        "user": "root",
        "password": "",
        "database": "heliactyl"
    }
}
EOF

# 6. Install Node Modules & PM2
echo "[5/5] Installing Node Modules and PM2 (This might take a minute)..."
cd /var/www/heliactyl
npm install
npm install pm2 -g

echo "======================================================="
echo "✅ Heliactyl Base Files Installed Successfully!"
echo "======================================================="
echo ""
echo "NEXT STEPS (SSL & NGINX):"
echo "1. Fix Nginx port & Setup SSL for your domain:"
echo "   sudo systemctl stop nginx"
echo "   certbot certonly -d yourdomain.com"
echo "   sudo systemctl start nginx"
echo "2. Configure your Nginx proxy in /etc/nginx/sites-enabled/"
echo "3. Start the panel:"
echo "   cd /var/www/heliactyl"
echo "   pm2 start index.js --name 'heliactyl'"
echo "   pm2 save && pm2 startup"
echo "======================================================="

