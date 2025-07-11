#!/usr/bin/env bash

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/install.sh)" "" --unattended
else
  echo "oh-my-zsh is already installed."
fi

# Symlink custom directory
rm -rf "$HOME/.oh-my-zsh/custom"
ln -svf "$(pwd)/.oh-my-zsh/custom" "$HOME/.oh-my-zsh/"

# Symlink .zshrc
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

# install Homebrew if it doesn't exist
if ! command -v brew &> /dev/null; then
  echo "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed."
fi

# while personal website still uses Jekyll
brew install --quiet rbenv
