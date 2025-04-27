#!/bin/bash

echo "🚀 Welcome to Fedora-Ultimate-Boost!"
echo "This will fully optimize your Fedora and set up a personal dev cloud."

sleep 2

echo "⚙️  STAGE 1: System Tweaks..."
# System tweaks
sudo tee -a /etc/dnf/dnf.conf <<EOF
fastestmirror=True
max_parallel_downloads=10
deltarpm=true
EOF
sudo dnf install -y preload tuned
sudo systemctl enable --now preload
sudo systemctl enable --now tuned
sudo tuned-adm profile throughput-performance

echo "🧹 Removing unnecessary bloat..."
sudo dnf remove -y libreoffice* rhythmbox* cheese* gnome-maps* gnome-weather* totem* yelp* gnome-contacts* gnome-calendar*

echo "⚡ Power Optimization..."
sudo dnf install -y tlp tlp-rdw
sudo systemctl enable --now tlp

echo "🎨 Improving GNOME responsiveness..."
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

sleep 2

echo "📚  STAGE 2: Developer Stack (Essential Tools)..."
sudo dnf groupinstall -y "Development Tools"
sudo dnf install -y nodejs npm python3 python3-pip php php-cli php-mysqlnd php-pgsql mariadb mariadb-server sqlite

# Increase file watchers (important for large projects)
echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sleep 2

echo "☁️  STAGE 3: Databases and Container Tools..."

# Install and configure databases
sudo dnf install -y postgresql-server postgresql-contrib
sudo postgresql-setup --initdb
sudo systemctl enable --now postgresql

sudo dnf install -y redis
sudo systemctl enable --now redis

# MongoDB repo
sudo tee /etc/yum.repos.d/mongodb-org.repo <<EOF
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF
sudo dnf install -y mongodb-org
sudo systemctl enable --now mongod

# RabbitMQ
sudo dnf install -y erlang socat
sudo dnf install -y https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.12.7/rabbitmq-server-3.12.7-1.el8.noarch.rpm
sudo systemctl enable --now rabbitmq-server

# Prometheus + Grafana
sudo dnf install -y prometheus
sudo systemctl enable --now prometheus

sudo tee /etc/yum.repos.d/grafana.repo <<EOF
[grafana]
name=Grafana Repository
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
sslverify=1
EOF
sudo dnf install -y grafana
sudo systemctl enable --now grafana-server

# Nginx
sudo dnf install -y nginx
sudo systemctl enable --now nginx

# Podman
sudo dnf install -y podman podman-compose

sleep 2

echo "🎛️  STAGE 4: Kubernetes Tools..."

# Kubernetes tools
sudo dnf install -y conntrack
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -Uvh minikube-latest.x86_64.rpm

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

sudo dnf install -y k9s

# Start Minikube
echo "🚀 Starting Minikube cluster..."
minikube start --driver=podman

# Deploy a sample app
echo "🛠️ Deploying sample app inside Minikube..."
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-node --type=NodePort --port=8080

sleep 2

echo "🔒 Setting up WireGuard VPN server..."

# Install WireGuard
sudo dnf install -y wireguard-tools

# Generate keys
wg genkey | tee privatekey | wg pubkey > publickey

PRIVATE_KEY=$(cat privatekey)
PUBLIC_KEY=$(cat publickey)

# Create basic WireGuard config
sudo tee /etc/wireguard/wg0.conf <<EOF
[Interface]
PrivateKey = $PRIVATE_KEY
Address = 10.200.200.1/24
ListenPort = 51820
SaveConfig = true

[Peer]
PublicKey = <client-public-key>
AllowedIPs = 10.200.200.2/32
EOF

sudo systemctl enable --now wg-quick@wg0

echo "✅ WireGuard VPN Server running! Remember to replace <client-public-key> with your device public key."

sleep 2

echo "🎉 Fedora-Ultimate-Boost Complete!"
echo "🛡️ Your machine is now a Mini-Cloud, VPN-ready, Kubernetes-ready, and hyper-optimized."
echo "💡 REBOOT is highly recommended to apply all changes."