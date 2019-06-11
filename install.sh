#!/usr/bin/env bash


ROOT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

cd $ROOT_DIR

source "$ROOT_DIR/functions.sh"

export ROOT_DIR

export -f print_info
export -f print_success
export -f print_error
export -f symlink_from_to
export -f symlink_dot
export -f modify_file
export -f modify_line
export -f insert_to_file_after_line_number
export -f uncomment_line
export -f prepend_string_to_file

ask_for_sudo

while true; do
  ask_for_confirmation "Warning: This shell will overwrite your current workspace setup. Proceed?"
  case $REPLY in
    [Yy]* ) break;;
    [Nn]* ) exit;;
    * ) echo "Please answer, yes or no"
  esac
done

print_info "Running sub-shells..."

for SHELL in $ROOT_DIR/shells/*
do
  print_info "Running $(basename $SHELL)..."
  sh $SHELL
done

# Install aliases
if [ -f $ROOT_DIR/config/.aliases ]; then
  source "$ROOT_DIR/config/.aliases"
fi

# print_info "Symlinking files..."
# declare -a SYMLINKS=(`ls $ROOT_DIR/symlinks | sed 's/^/symlinks\//'`)
# symlink_dot ${SYMLINKS[@]}

# sh "$ROOT_DIR/core/brew-services.sh"

# exec zsh