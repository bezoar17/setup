#!/usr/bin/env bash

echo "=> Front End Setup"

if ! brew list nvm &>/dev/null; then
  print_info "Installing..."

  # Install nvm (http://dev.topheman.com/install-nvm-with-homebrew-to-use-multiple-versions-of-node-and-iojs-easily/)
  brew install nvm
  mkdir ~/.nvm

  echo 'export NVM_DIR=\"$HOME/.nvm\"' >> ~/.bash_profile
  echo 'source $(brew --prefix nvm)/nvm.sh' >> ~/.bash_profile
  # also install these on zshrc

  # Install node
  nvm install v8.11.0

  # Install yarn
  brew install yarn

  if [[ -d "$HOME/Development/dash" ]]; then
    cd ~/Development/dash && yarn install
  fi

  print_success "Completed..."
else
  print_success "Skipping..."
fi