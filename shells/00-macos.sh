#!/usr/bin/env bash

echo "=> Mac OS defaults"

if [[ -f "$ROOT_DIR/config/.macos" ]]; then
  print_info "Updating MacOS preferences..."

  source "$ROOT_DIR/config/.macos"

  print_success "Completed..."
else
  print_success "Skipping..."
fi