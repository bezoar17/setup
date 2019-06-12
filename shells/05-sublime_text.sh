#!/usr/bin/env bash

echo "=> Sublime Text"

DIR=$(echo "$HOME/Library/Application Support/Sublime Text 3")
BASE_DIR=$(echo "$ROOT_DIR/config/sublime_text/Preferences.sublime-settings")

print_info "Installing package control..."

if [ ! -f "$DIR/Installed Packages/Package Control.sublime-package" ]
then
  osascript -e 'quit app "Sublime Text"'

  curl -o "$DIR/Installed Packages/Package Control.sublime-package" \
          "https://packagecontrol.io/Package Control.sublime-package"

  print_success "Completed..."
else
  print_success "Skipping..."
fi

print_info "Creating a shortcut for sublime_text as subl"

ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

print_success "Completed..."

print_info "Updating default user preferences..."

if [[ ! -d "$DIR/Packages/User" ]]; then
  mkdir "$DIR/Packages/User"
  cp "$BASE_DIR" "$DIR/Packages/User"
  print_success "Completed..."
else
  print_success "Skipping as defaults already present..."
fi