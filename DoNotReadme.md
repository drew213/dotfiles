# My Dotfiles Lab 🚀

These are my personal dotfiles to bootstrap any Fedora/Ubuntu/Mac/Arch machine.

## Installation

```bash
git clone https://github.com/YOURUSERNAME/dotfiles.git
cd dotfiles
bash install.sh

## This is the End of the Line
## Stop Here
## Okay you kept coming so you must know

# 🚫 DO-NOT-README: Fedora-Ultimate-Boost

Welcome warrior.  
This is not a beginner README. You are about to operate a **personal cloud machine**.

## 🛠 What This Setup Does:
- Blasts Fedora to maximum performance.
- Turns your PC into a private cloud (databases, Kubernetes, VPN).
- Boosts file watching limits for huge codebases.
- Deploys local apps to a real Kubernetes cluster (Minikube).
- VPN into your machine anywhere in the world using WireGuard.

---

## 🗺️ Stack Map:

| Tool | Purpose |
|:---|:---|
| DNF Tweaks | Lightning-fast package manager |
| preload + tuned | Faster app launch, kernel performance boost |
| Node, PHP, Python | Full webapp development |
| PostgreSQL, MongoDB, Redis, RabbitMQ | Full backend database stack |
| Nginx | Reverse Proxy deployments |
| Prometheus + Grafana | Metrics and Monitoring |
| Kubernetes (Minikube) | Local Cloud |
| Podman | Lightweight Containers |
| WireGuard | Remote access VPN |

---

## 🚀 Usage Tips

### 1. Start Minikube Cluster
```bash
minikube start --driver=podman
kubectl create deployment hello-world --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-world --type=NodePort --port=8080
minikube service hello-world

sudo systemctl start wg-quick@wg0


---

# 🎯 Next steps:

- I'll polish this even more by making the WireGuard part fully dynamic (auto-adding new clients).
- Maybe even make a GUI launcher for it all (if you want, later).

---

# 🚀  
Would you also like me to create an **Auto-Installer version** (one-liner you paste and it does everything)?  
Example: 

```bash
curl -s https://your-domain.com/fedora-ultimate-boost.sh | bash
