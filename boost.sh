#!/bin/bash
echo "Boosting Fedora DNF configuration..."
sudo grep -q '^fastestmirror=True' /etc/dnf/dnf.conf || echo 'fastestmirror=True' | sudo tee -a /etc/dnf/dnf.conf
sudo grep -q '^max_parallel_downloads=10' /etc/dnf/dnf.conf || echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
sudo grep -q '^deltarpm=True' /etc/dnf/dnf.conf || echo 'deltarpm=True' | sudo tee -a /etc/dnf/dnf.conf
echo "Done!"
