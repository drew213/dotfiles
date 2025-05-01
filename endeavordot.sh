#!/bin/bash

# === Basic System Setup ===
echo "==> Installing essentials and yay..."
sudo pacman -Syu --noconfirm git base-devel

git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -si --noconfirm && cd ..

# === Install Core Packages ===
echo "==> Installing terminal, shell, prompt, editors, and core utilities..."
yay -S --noconfirm \
  fish \
  starship \
  alacritty \
  visual-studio-code-bin \
  phpstorm \
  tmux \
  zellij \
  htop \
  btop \
  timeshift \
  ufw \
  fail2ban \
  wireshark-qt \
  tor \
  proxychains-ng \
  metasploit \
  burpsuite \
  docker \
  docker-compose

# === Enable Services ===
echo "==> Enabling firewall and docker..."
sudo systemctl enable --now ufw
sudo systemctl enable --now docker

# === Setup Fish Shell ===
echo "==> Setting up Fish and Starship..."
chsh -s /usr/bin/fish

mkdir -p ~/.config/fish
cat << 'EOF' > ~/.config/fish/config.fish
# Fish config
starship init fish | source

# Aliases
alias cls="clear"
alias update="yay -Syu"
alias ll="ls -la"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias ..="cd .."

# Editor
set -Ux EDITOR code
EOF

# === Alacritty Config ===
echo "==> Setting up Alacritty config..."
mkdir -p ~/.config/alacritty
cat << 'EOF' > ~/.config/alacritty/alacritty.yml
window:
  padding:
    x: 10
    y: 10
  decorations: full
  opacity: 0.95

font:
  normal:
    family: JetBrainsMono Nerd Font
  size: 12

draw_bold_text_with_bright_colors: true
EOF

# === Starship Config ===
echo "==> Setting up Starship prompt..."
mkdir -p ~/.config
cat << 'EOF' > ~/.config/starship.toml
format = "$all"

[character]
success_symbol = "[➜](bold green) "
error_symbol = "[✗](bold red) "

[directory]
truncation_length = 3
EOF

# === Finish ===
echo "✅ Setup complete! Restart your terminal or reboot to see changes."
