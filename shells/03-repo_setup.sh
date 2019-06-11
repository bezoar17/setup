#!/usr/bin/env bash

echo "=> Setup Track Repo"

if [[ ! -d "$HOME/Development/dash" ]]; then
  print_info "Installing..."

  # Create a Development folder
  cd $HOME && mkdir Development
  cd Development

  # Clone the repo
  git clone https://github.com/aggrata/dash.git

  print_success "Completed..."

  print_info "Goto https://github.com/aggrata/dash for instructions on how to setup the app."
else
  print_success "Skipping..."
fi