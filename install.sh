#!/usr/bin/env bash

# config related
REPO_NAME="setup"
DEV_DIR="$HOME/Development"
MACKUP_PATH_FROM_HOME=".hallows"
# config related

ROOT_DIR="$(cd "$(dirname "$0")"; pwd -P)"

cd $ROOT_DIR

source "$ROOT_DIR/functions.sh"

export ROOT_DIR
export DEV_DIR
export REPO_NAME
export MACKUP_PATH_FROM_HOME

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
export -f ask
export -f ask_for_confirmation # should always be used in a subprocess, i.e, (). see repo setup for e.g.
export -f ask_for_confirmed_input

ask_for_sudo

ask_for_confirmation "Warning: This shell will overwrite your current workspace setup. Proceed?"

if [ $# -eq 0 ]; then # no arguments are provided
  print_info "Running all sub-shells..."
  for SHELL in $ROOT_DIR/shells/*
  do
    print_info "Running $(basename $SHELL)..."
    sh $SHELL
  done
else
  FILE="$(ls $ROOT_DIR/shells/$1*)"
  print_info "Running sub shell $FILE..."
  sh $FILE
fi

# NOTE: this should only be done for cases where this has to be run only once,
# maybe for setting up new machines, hence deletion is delegated to index.sh

# print_info "The work is done, you should now delete this folder."
# ask_for_confirmation "Should we go ahead and delete it for you ?"
# case $REPLY in
#   [Yy]* ) cd $HOME && rm -r $ROOT_DIR && cd $HOME && exit;;
#   [Nn]* ) exit;;
#   * ) echo "Please answer, yes or no"
# esac