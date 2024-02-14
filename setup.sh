#!/usr/bin/bash

main() {
  update_package_lists
  install_zsh
  install_lsd
  install_nvim
  install_starship
}

# Update package lists
update_package_lists() {
  sudo apt-get update -y
}

# Check to see if an app is already installed on the system. 
is_installed() {
  app_name=$1

  if which $app_name &> /dev/null; then
    echo true
  else
    echo false
  fi
}

# Install Zsh.
# https://www.zsh.org/
install_zsh() {
  if $(is_installed zsh); then
    echo "Zsh is already installed"
    return 0
  fi

  sudo apt install zsh -y
  
  # Sets Zsh as the default shell.
  chsh -s $(which zsh)
}

# Install LSD (LSDeluxe) ls replacement.
# https://github.com/lsd-rs/lsd
install_lsd() {
  if $(is_installed lsd); then
    echo "LSD is already installed"
    return 0
  fi

  echo "Installing LSD..."
  sudo apt install lsd -y
}

# Install Starship (Custom Prompt)
# https://starship.rs/
install_starship() {
  if $(is_installed starship); then
    echo "Starship is already installed"
    return 0
  fi

  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh
}

# Install Neovim.
# https://neovim.io/
install_nvim() {
  if $(is_installed nvim); then
    echo "Neovim is already installed"
    return 0
  fi
  
  echo "Installing Neovim..."
  curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  sudo rm -rf /opt/nvim
  sudo tar -C /opt -xzf nvim-linux64.tar.gz
}

# Run the main function when the script runs.
main

# NOTES
# Somewhere need to add global Git settings
# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
# 
# Maybe add this git config as well:
# git config --global --add --bool push.autoSetupRemote true
# This creates new branches in the remote when they are pushed.
