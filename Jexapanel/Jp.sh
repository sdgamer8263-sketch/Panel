#!/bin/bash
# Jexactyl Auto Installer with OS Detection + SDGAMER Banner (Silent Mode)
set -e
export DEBIAN_FRONTEND=noninteractive

# Enhanced Colors for UI
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
MAGENTA='\033[1;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# UI Elements
BOLD='\033[1m'
UNDERLINE='\033[4m'

# Logging setup
log_file="/var/log/sdgamer-install.log"
exec > >(tee -a "$log_file") 2>&1

# Enhanced Progress display functions
print_header() {
    echo -e "${CYAN}"
    echo -e "╔══════════════════════════════════════════════════════════════╗"
    echo -e "║${WHITE}           🦖 Jexactyl Auto Installer${CYAN}                     ║"
    echo -e "║                 ${WHITE}Powered by SDGAMER${CYAN}                      ║"
    echo -e "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

show_progress() {
    echo -e "${CYAN}${BOLD}[~]${NC} $1..."
}

show_success() {
    echo -e "${GREEN}${BOLD}[✓]${NC} $1"
}

show_warning() {
    echo -e "${YELLOW}${BOLD}[!]${NC} $1"
}

show_error() {
    echo -e "${RED}${BOLD}[✗]${NC} $1"
}

show_info() {
    echo -e "${BLUE}${BOLD}[i]${NC} $1"
}

# Function to show progress bar
progress_bar() {
    local duration=$1
    local steps=20
    local step_delay=$(echo "scale=3; $duration/$steps" | bc -l 2>/dev/null || echo "0.1")
    
    echo -ne "${BLUE}["
    for ((i=0; i<steps; i++)); do
        echo -ne "█"
        sleep $step_delay
    done
    echo -e "]${NC}"
}

# Function to animate text
animate_text() {
    local text=$1
    echo -ne "${CYAN}"
    for ((i=0; i<${#text}; i++)); do
        echo -n "${text:$i:1}"
        sleep 0.02
    done
    echo -e "${NC}"
}

# Error handling function
handle_error() {
    show_error "Error occurred in step: $1"
    echo -e "${YELLOW}📋 Check log file: $log_file${NC}"
    # When error happens, offering redirect before exit
    echo -e "${MAGENTA}Redirecting to SDGAMER Main Menu...${NC}"
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
    exit 1
}

# Silent command execution with progress
run_silent() {
    local step_name="$1"
    local command="$2"
    
    show_progress "$step_name"
    if eval "$command" > /dev/null 2>&1; then
        show_success "$step_name completed"
        return 0
    else
        handle_error "$step_name"
        return 1
    fi
}

# Clear and Display SDGAMER Banner
clear
echo -e "${MAGENTA}"
echo -e "╔══════════════════════════════════════════════════════════════╗"
echo -e "║${CYAN}                                                          ${MAGENTA}║"
echo -e "║${CYAN}  ███████╗██████╗  ██████╗  █████╗ ███╗   ███╗███████╗██████╗  ${MAGENTA}║"
echo -e "║${CYAN}  ██╔════╝██╔══██╗██╔════╝ ██╔══██╗████╗ ████║██╔════╝██╔══██╗ ${MAGENTA}║"
echo -e "║${CYAN}  ███████╗██║  ██║██║  ███╗███████║██╔████╔██║█████╗  ██████╔╝ ${MAGENTA}║"
echo -e "║${CYAN}  ╚════██║██║  ██║██║   ██║██╔══██║██║╚██╔╝██║██╔══╝  ██╔══██╗ ${MAGENTA}║"
echo -e "║${CYAN}  ███████║██████╔╝╚██████╔╝██║  ██║██║ ╚═╝ ██║███████╗██║  ██║ ${MAGENTA}║"
echo -e "║${CYAN}  ╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝ ${MAGENTA}║"
echo -e "║${WHITE}                                                          ${MAGENTA}║"
echo -e "║${WHITE}              SDGAMER Auto Installer                      ${MAGENTA}║"
echo -e "║${YELLOW}              (Silent Mode - Custom Build)                ${MAGENTA}║"
echo -e "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# OS Detection
show_progress "Detecting operating system"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    VER=$VERSION_ID
    show_success "Detected: $OS $VER"
else
    show_error "Unsupported OS. Exiting."
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
    exit 1
fi

# Supported Systems check
if [[ "$OS" != "ubuntu" && "$OS" != "debian" ]]; then
    show_error "Unsupported OS. This script supports Ubuntu/Debian only."
    bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
    exit 1
fi

# Domain input
echo -e ""
echo -e "${CYAN}${BOLD}Domain Configuration:${NC}"
echo -e "${WHITE}Please enter your domain name for Jexactyl${NC}"
read -p "$(echo -e "${YELLOW}➤ Enter your domain (example.com): ${NC}")" DOMAIN

if [[ ! "$DOMAIN" =~ ^[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
    show_error "Invalid domain format"
    exit 1
fi

# Generate credentials
DB_NAME="SDG_Jex"
DB_USER="SDG_User"
DB_PASS=$(openssl rand -base64 32)
JEXACTYL_VERSION="v4.0.0-rc2"

echo -e ""
echo -e "${PURPLE}${BOLD}Starting SDGAMER Installation Process...${NC}"
sleep 2

# Step 1: System Preparation
echo -e "\n${PURPLE}${BOLD}╔════════ Step 1: System Preparation ════════╗${NC}"
run_silent "Updating system packages" "apt-get update -y"
run_silent "Installing dependencies" "apt-get install -y software-properties-common curl apt-transport-https ca-certificates gnupg lsb-release bc"

# Add PHP repository
show_progress "Adding PHP repository"
if [[ "$OS" == "ubuntu" ]]; then
    LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php > /dev/null 2>&1
elif [[ "$OS" == "debian" ]]; then
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list > /dev/null
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/php.gpg > /dev/null 2>&1
fi
show_success "PHP repository added"

run_silent "Updating repository cache" "apt-get update -y"

# Step 2: Package Installation
echo -e "\n${PURPLE}${BOLD}╔════════ Step 2: Package Installation ════════╗${NC}"
show_progress "Installing PHP and services"
animate_text "SDGAMER Deployment: PHP 8.3, MariaDB, Nginx, Redis..."
apt-get install -y php8.3 php8.3-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server cron > /dev/null 2>&1 &
progress_bar 15
show_success "All packages installed"

show_progress "Installing Composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1
show_success "Composer installed"

# Step 3: Jexactyl Setup
echo -e "\n${PURPLE}${BOLD}╔════════ Step 3: SDGAMER Jexactyl Setup ════════╗${NC}"
run_silent "Creating web directory" "mkdir -p /var/www/jexactyl"
cd /var/www/jexactyl || handle_error "Directory change"

show_progress "Downloading Jexactyl files"
curl -Lo panel.tar.gz "https://github.com/jexactyl/jexactyl/releases/download/${JEXACTYL_VERSION}/panel.tar.gz" > /dev/null 2>&1
show_success "Jexactyl downloaded"

run_silent "Extracting files" "tar -xzf panel.tar.gz"
run_silent "Setting permissions" "chmod -R 755 storage/* bootstrap/cache/"
run_silent "Setting ownership" "chown -R www-data:www-data /var/www/jexactyl/*"

# Step 4: Database Setup
echo -e "\n${PURPLE}${BOLD}╔════════ Step 4: Database Setup ════════╗${NC}"
run_silent "Starting MariaDB service" "systemctl enable --now mariadb"

show_progress "Configuring database"
mariadb -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'127.0.0.1' IDENTIFIED BY '${DB_PASS}';" > /dev/null 2>&1
mariadb -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};" > /dev/null 2>&1
mariadb -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'127.0.0.1' WITH GRANT OPTION;" > /dev/null 2>&1
mariadb -e "FLUSH PRIVILEGES;" > /dev/null 2>&1
show_success "Database configured"

# Step 5: Environment Configuration
echo -e "\n${PURPLE}${BOLD}╔════════ Step 5: Environment Config ════════╗${NC}"
run_silent "Copying environment file" "cp -R .env.example .env"

echo "RECAPTCHA_ENABLED=false" >> .env
sed -i "s|APP_URL=.*|APP_URL=https://${DOMAIN}|g" .env
sed -i "s|DB_DATABASE=.*|DB_DATABASE=${DB_NAME}|g" .env
sed -i "s|DB_USERNAME=.*|DB_USERNAME=${DB_USER}|g" .env
sed -i "s|DB_PASSWORD=.*|DB_PASSWORD=${DB_PASS}|g" .env
show_success "Environment variables configured"

show_progress "Running Composer installation"
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader > /dev/null 2>&1
show_success "Composer dependencies installed"

run_silent "Generating application key" "php artisan key:generate --force"
run_silent "Running database migrations" "php artisan migrate --seed --force"

# Step 6: Service Configuration
echo -e "\n${PURPLE}${BOLD}╔════════ Step 6: Service Configuration ════════╗${NC}"
run_silent "Setting up cron service" "systemctl enable --now cron"
(crontab -l 2>/dev/null; echo "* * * * * php /var/www/jexactyl/artisan schedule:run >> /dev/null 2>&1") | crontab - > /dev/null 2>&1

show_progress "Setting up queue worker"
cat >/etc/systemd/system/jxctl.service <<EOL
[Unit]
Description=SDGAMER Jexactyl Queue Worker

[Service]
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php /var/www/jexactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOL
run_silent "Enabling queue worker" "systemctl enable --now jxctl.service"

# Step 7: SSL & Web Server
echo -e "\n${PURPLE}${BOLD}╔════════ Step 7: SSL & Web Server ════════╗${NC}"
run_silent "Creating SSL directory" "mkdir -p /etc/certs/SDG"
cd /etc/certs/SDG
openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=NA/ST=NA/L=NA/O=SDGAMER/CN=${DOMAIN}" -keyout privkey.pem -out fullchain.pem > /dev/null 2>&1

cat >/etc/nginx/sites-available/jexactyl.conf <<EOL
server {
    listen 80;
    server_name ${DOMAIN};
    return 301 https://\$server_name\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name ${DOMAIN};
    root /var/www/jexactyl/public;
    index index.php;
    client_max_body_size 100m;
    ssl_certificate /etc/certs/SDG/fullchain.pem;
    ssl_certificate_key /etc/certs/SDG/privkey.pem;
    location / { try_files \$uri \$uri/ /index.php?\$query_string; }
    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php8.3-fpm.sock;
    }
}
EOL

run_silent "Enabling site" "ln -sf /etc/nginx/sites-available/jexactyl.conf /etc/nginx/sites-enabled/jexactyl.conf"
run_silent "Restarting web services" "systemctl restart nginx php8.3-fpm"

# Step 8: Final Setup
echo -e "\n${PURPLE}${BOLD}╔════════ Step 8: Final Setup ════════╗${NC}"
cd /var/www/jexactyl
php artisan p:user:make
run_silent "Finalizing configuration" "sed -i '/^APP_ENVIRONMENT_ONLY=/d' .env && echo 'APP_ENVIRONMENT_ONLY=false' >> .env"

# Final summary
clear
print_header
echo -e "${GREEN}🎉 Jexactyl Installation Completed by SDGAMER!${NC}"
echo -e "\n${CYAN}${BOLD}🌐 Access:${NC} https://${DOMAIN}"
echo -e "${CYAN}${BOLD}🗄️  DB User:${NC} ${DB_USER}"
echo -e "${CYAN}${BOLD}🔑 DB Pass:${NC} ${DB_PASS}"
echo -e "\n${MAGENTA}Redirecting to SDGAMER Main Menu in 10 seconds...${NC}"
sleep 10

# Final Exit Redirect
bash <(curl -sL https://raw.githubusercontent.com/sdgamer8263-sketch/Panel/main/run.sh)
exit 0
