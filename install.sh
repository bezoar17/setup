#!/usr/bin/env bash


REPO_NAME="setup"
DEV_DIR="Development"
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

if [ $# -eq 0 ]; then
  for SHELL in $ROOT_DIR/shells/*
  do
    print_info "Running $(basename $SHELL)..."
    sh $SHELL
  done
else
  FILE="$(ls $ROOT_DIR/shells/$1*)"
  echo "Running $FILE..."
  sh $FILE
fi

# print_info "The work is done, you should now delete this folder."
# ask_for_confirmation "Should we go ahead and delete it for you ?"
# case $REPLY in
#   [Yy]* ) cd $HOME && rm -r $ROOT_DIR && cd $HOME && exit;;
#   [Nn]* ) exit;;
#   * ) echo "Please answer, yes or no"
# esac

