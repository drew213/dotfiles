#!/bin/bash

echo "🚀 Starting dotfiles installation..."

# List of dotfiles to symlink
files=(".bashrc" ".zshrc" ".gitconfig" ".vimrc")

for file in "${files[@]}"; do
    ln -sf "$PWD/$file" "$HOME/$file"
done

# Create .config/starship.toml
mkdir -p $HOME/.config
ln -sf "$PWD/starship.toml" "$HOME/.config/starship.toml"

# Source aliases inside zshrc
echo "source ~/aliases.zsh" >> ~/.zshrc
ln -sf "$PWD/aliases.zsh" "$HOME/aliases.zsh"

echo "✅ Dotfiles installed successfully!"

sudo nano /etc/dnf/dnf.conf
fastestmirror=True
max_parallel_downloads=10
deltarpm=true