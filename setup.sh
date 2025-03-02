#!/usr/bin/env bash
rm -rf "$HOME/.zshrc"
ln -svf "$(pwd)/.zshrc" "$HOME/.zshrc"

# ensure .config exists
mkdir -p "$HOME/.config"

# remove existing directories if they exist
rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.config/starship"
rm -rf "$HOME/.config/wezterm"

sudo ln -svf "$(pwd)/.config/nvim" "$HOME/.config"
sudo ln -svf "$(pwd)/.config/starship" "$HOME/.config"
sudo ln -svf "$(pwd)/.config/wezterm" "$HOME/.config"
