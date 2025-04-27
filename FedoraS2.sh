#!/bin/bash

echo "🏎️ Starting Fedora Supercar Stage 2 - Overclock Optimization..."

# --- 1. ZRAM Setup (better memory compression)
echo "🧠 Setting up ZRAM for RAM compression..."
sudo dnf install -y zram-generator-defaults
sudo systemctl enable --now systemd-zram-setup@zram0

# --- 2. EarlyOOM (prevent freezes when RAM runs out)
echo "🚑 Installing EarlyOOM..."
sudo dnf install -y earlyoom
sudo systemctl enable --now earlyoom

# --- 3. Auto-CPUFreq (dynamic CPU scaling for performance)
echo "🚀 Installing Auto-CPUFreq..."
git clone https://github.com/AdnanHodzic/auto-cpufreq.git /tmp/auto-cpufreq
cd /tmp/auto-cpufreq
sudo ./auto-cpufreq-installer
auto-cpufreq --install

# --- 4. System Swappiness Tweak (prefer RAM over swap)
echo "🧹 Reducing swappiness (prefer RAM)..."
echo "vm.swappiness=10" | sudo tee /etc/sysctl.d/99-swappiness.conf
sudo sysctl --system

# --- 5. CPU Governor to Performance
echo "🔥 Setting CPU governor to 'performance'..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
  echo performance | sudo tee $cpu
done

# --- 6. Remove unnecessary services (carefully)
echo "🧹 Disabling unnecessary startup services (boost boot time)..."
sudo systemctl disable packagekit
sudo systemctl disable cups
sudo systemctl disable ModemManager
sudo systemctl disable bluetooth

# --- 7. Install tuned and apply performance profile
echo "🎛️ Installing and applying Tuned performance profile..."
sudo dnf install -y tuned
sudo systemctl enable --now tuned
sudo tuned-adm profile throughput-performance

# --- 8. Install better shell (optional but recommended)
echo "🐚 Installing fast shell (fish)..."
sudo dnf install -y fish
chsh -s /usr/bin/fish

# --- 9. Cleanup temp files
echo "🧹 Cleaning temporary files..."
sudo rm -rf /tmp/auto-cpufreq

# --- 10. Final message
echo "✅ Fedora Supercar Stage 2 Overclock complete!"
echo "💡 REBOOT is highly recommended now to apply EVERYTHING."

