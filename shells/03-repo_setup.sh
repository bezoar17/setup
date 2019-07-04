#!/usr/bin/env bash

# Uses $DEV_DIR defined in install.sh

# if .ssh is not present, start ssh key creation in a subshell
if [[ ! -d "$HOME/.ssh" ]]; then
  (
    print_info "~/.ssh folder not found, keys will be setup as instructed in \n
    https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent."

    ask_for_confirmation "Proceed ?"

    ask_for_confirmed_input "Enter your email: " # sets $input after confirmation
    email=$input

    print_info "Creating an ssh key ......"

    ssh-keygen -t rsa -b 4096 -C "$email"

    print_success "Created ssh key ......"

    print_info "Adding key to ssh-agent ......"

    eval "$(ssh-agent -s)"

    print_info "Updating ssh config ......"

    echo "Host *
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/id_rsa" > ~/.ssh/config

    ssh-add -K ~/.ssh/id_rsa

    print_success "Completed ......"

    print_info "Now add the key to your github account, https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account"
    read -p "Waiting ..... press enter to continue ... "
    exit
  )
fi

echo "=> Setting up development repos"

# Start cloning repos
if [ -f "$ROOT_DIR/config/repos.json" ]; then
  for repo_info in $(jq -c '.[]' config/repos.json) # -c is compact mode
  do
    git_url=$(echo $repo_info | jq -r '.git_url') # -r is for raw output(without quotes)
    path=$(echo $repo_info | jq -r '.path')
    repo_name=${git_url##*/} # last element after split('/')
    repo_name=$(echo $repo_name | cut -d '.' -f 1) # first element after split('.')

    print_info "Cloning $git_url..."

    # if path is null, move to dev_dir, else move to the path
    if [ $path == "null" ]; then cd $DEV_DIR; else mkdir -p $DEV_DIR/$path; cd $DEV_DIR/$path; fi

    # pull if repo present, else clone (: is equivalent of no-op)
    if git -C $repo_name pull; then : ; else git clone $git_url; fi

    print_success "Completed..."
  done
else
  print_success "No repo config found, skipping..."
fi
