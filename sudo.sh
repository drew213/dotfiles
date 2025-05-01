#!/bin/bash

echo "🔥 Starting Dev Environment Setup 🔥"

# Update and upgrade
sudo yay update -y
sudo yay upgrade -y

# Essential packages
sudo yay install -y git zsh curl wget gcc gcc-c++ make python3-pip

# Install Node Version Manager (nvm) and Node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts
npm install -g yarn pnpm bun

# Install pyenv + latest Python
curl https://pyenv.run | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
exec $SHELL
pyenv install 3.12.2
pyenv global 3.12.2
pip install --upgrade pip
pip install virtualenvwrapper numpy pandas scipy matplotlib jupyterlab

# Install PHP + Composer
sudo yay install -y php php-cli php-common php-mbstring php-xml php-pdo php-mysqlnd php-gd
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install Dev Tools
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo yay check-update
sudo yay install -y code 

# Install Brave browser
sudo yay install yay-plugins-core
sudo yay config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo yay install -y brave-browser

# Optional: Docker, Postgres, Redis
sudo yay install -y docker docker-compose postgresql-server redis
sudo systemctl enable docker --now
sudo systemctl enable postgresql --now
sudo systemctl enable redis --now

# Setup GNOME Tweaks
sudo yay install -y gnome-tweaks

# adding file download speed improvement
sudo grep -q '^fastestmirror=True' /etc/yay/yay.conf || echo 'fastestmirror=True' | sudo tee -a /etc/yay/yay.conf
sudo grep -q '^max_parallel_downloads=10' /etc/yay/yay.conf || echo 'max_parallel_downloads=10' | sudo tee -a /etc/yay/yay.conf
sudo grep -q '^deltarpm=True' /etc/yay/yay.conf || echo 'deltarpm=True' | sudo tee -a /etc/yay/yay.conf

# Finished!
echo "✅ Dev Environment setup complete! 🚀"
