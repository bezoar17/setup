#!/usr/bin/env bash

# Uses $DEV_DIR defined in install.sh
# Setup github with a gpg or ssh key

echo "=> Setting up development repos"

# Start cloning repos
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
