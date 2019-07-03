#!/usr/bin/env bash

echo "=> Sublime Text"

DIR=$(echo "$HOME/Library/Application Support/Sublime Text 3")

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