#!/usr/bin/env bash

echo "=> Mackup magic"

print_info "Setting up Mackup..."

if ! brew list mackup &>/dev/null; then
  print_info "Installing Mackup..."

  brew install mackup
fi

print_info "Copying latest settings..."

# copy the mackup configs first, .mackup.cfg tells mackup where to look
cp "$ROOT_DIR/$MACKUP_PATH_FROM_HOME/Mackup/.mackup.cfg" "$HOME"
# copy other mackup configs saved in .mackup
if [[ -d "$ROOT_DIR/$MACKUP_PATH_FROM_HOME/Mackup/.mackup" ]]; then
  cp -r "$ROOT_DIR/$MACKUP_PATH_FROM_HOME/Mackup/.mackup" "$HOME"
fi

# separately copy the folder
cp -r "$ROOT_DIR/$MACKUP_PATH_FROM_HOME" "$HOME"

print_info "Copy Completed..."

print_info "Restoring latest settings..."
mackup restore
print_success "Completed..."