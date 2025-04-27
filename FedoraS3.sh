#!/bin/bash

echo "🎯 Starting Fedora Developer Focus Pack Setup..."

# --- 1. Install Core Dev Tools
echo "📦 Installing Development Essentials..."
sudo dnf groupinstall "Development Tools" -y
sudo dnf install -y gcc gcc-c++ make cmake ninja-build python3-devel openssl-devel curl git wget unzip

# --- 2. Install Node.js + NVM + PNPM + Yarn
echo "🛠️ Installing Node.js Tools..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"
nvm install --lts
npm install -g pnpm yarn

# --- 3. Install Python Tooling (pipx, poetry, venvwrapper)
echo "🐍 Setting up Python Environment Managers..."
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install poetry
sudo dnf install -y python3-virtualenvwrapper

# --- 4. Install Docker and Docker Compose
echo "🐳 Installing Docker..."
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker

# --- 5. Install VSCode
echo "📝 Installing VS Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# --- 6. Install JetBrains Mono Nerd Font
echo "🏛️ Installing Developer Font (JetBrains Mono Nerd Font)..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip
rm JetBrainsMono.zip
fc-cache -fv

# --- 7. Improve File Watchers (important for Vite, Webpack, Next.js)
echo "🔍 Raising file watch limits..."
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# --- 8. Install Prettier, ESLint Globally
echo "🎨 Installing Global Formatters..."
npm install -g prettier eslint

# --- 9. Final cleanups
echo "✅ Developer Focus Pack installed successfully!"
echo "💡 You should reboot to activate file watcher improvements."

