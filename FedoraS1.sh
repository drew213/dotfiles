#!/bin/bash

echo "🏎️  Starting Fedora Supercar Optimization Script..."

# --- 1. Speed up DNF
echo "🚀 Boosting DNF (package manager)..."
sudo grep -q '^fastestmirror=True' /etc/dnf/dnf.conf || echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
sudo grep -q '^max_parallel_downloads=10' /etc/dnf/dnf.conf || echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
sudo grep -q '^deltarpm=True' /etc/dnf/dnf.conf || echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf

# --- 2. Update system fully
echo "🔄 Updating your system..."
sudo dnf upgrade --refresh -y

# --- 3. Install performance essentials
echo "🛠 Installing performance and optimization packages..."
sudo dnf install -y tlp powertop lm_sensors gnome-tweaks preload

# --- 4. Enable TLP (power saving)
echo "🔋 Enabling TLP for better battery and power management..."
sudo systemctl enable tlp
sudo systemctl start tlp

# --- 5. Install Flatpak support (futureproof your apps)
echo "📦 Setting up Flatpak..."
sudo dnf install -y flatpak
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# --- 6. Fix file watcher limit (for large projects like React, Next.js)
echo "👀 Increasing file watcher limits for development (React / Next.js / etc.)..."
echo "fs.inotify.max_user_watches=524288" | sudo tee /etc/sysctl.d/40-max-user-watches.conf
sudo sysctl --system

# --- 7. Minor GNOME Performance Tweaks
echo "⚙️ Tweaking GNOME settings (animations off for faster UX)..."
gsettings set org.gnome.desktop.interface enable-animations false

# --- 8. Clean DNF cache to reclaim space
echo "🧹 Cleaning DNF cache..."
sudo dnf clean all

# --- 9. Final message
echo "✅ Fedora Supercar Boost complete!"
echo "💡 Recommended: Reboot your machine to apply all changes."

