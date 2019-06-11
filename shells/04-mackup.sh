#!/usr/bin/env bash

echo "=> Mackup magic"

print_info "Setting up Mackup..."

if ! brew list mackup &>/dev/null; then
  print_info "Installing Mackup..."

  brew install mackup
fi

print_info "Copying latest settings..."

# copy the mackup configs first
cp "$ROOT_DIR/.hallows/Mackup/.mackup.cfg" "$HOME"

if [[ -d "$ROOT_DIR/.hallows/Mackup/.mackup" ]]; then
  cp -r "$ROOT_DIR/.hallows/Mackup/.mackup" "$HOME"
fi

# separately copy the folder
cp -r "$ROOT_DIR/.hallows" "$HOME"

print_info "Copy Completed..."

print_info "Restoring latest settings..."
mackup restore
print_success "Completed..."