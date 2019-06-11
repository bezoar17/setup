#!/usr/bin/env bash

echo "=> Homebrew"

if [[ ! -f $(which brew) ]];then
  print_info "Installing Homebrew..."

  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  print_success "Skipping..."
fi

print_info "Brewing from file..."

if [[ -f "$ROOT_DIR/config/Brewfile") ]]; then

  brew bundle --verbose --file="$ROOT_DIR/config/Brewfile"
  brew cleanup && brew upgrade && brew update && brew doctor

  print_success "Completed..."
else
  print_success "Skipped..."
fi