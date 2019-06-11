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

print_info "Updating default user preferences..."

rm -rf "$DIR/Packages/User/Preferences.sublime-settings"
cp "$BASE_DIR" "$DIR/Packages/User"