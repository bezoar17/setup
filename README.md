# setup

### Single command installation from anywhere
Just run `curl -L setup.vkashyap.now.sh | sh`  on any mac to kickstart the installation.

## TO-DO
+ Update Readme
+ Update repo installation shell
+ configurize directories
+ configurize mackup directory
+ ensure contextual aliases are defined through configs

## What is this about ?
Setting up a new machine or keeping the dotfiles/config files for applications in sync. This repo will be updated regularly to ensure that any new machine can be setup with the same applications/configs etc, using a single command. To ensure this happens, any new application installation or config changes should be done through the main `install.sh` command itself.

## How to maintain this ?
You are essentially keeping a track of all the changes made to your mac in this repo. If you install a new app, do it through install.sh.

If you change a setting try doing it through .macos preferences file.
If you add a repo to be cloned, do it through this.
If not, atleast track what needs to be done apart from just running install.sh once.



## Disclaimer
If you want to use this, do not copy the repo blindly, fork it, make changes acc. to your convenience and only then proceed with the installation.

## The stuff
The main entry point for this is `install.sh`. It runs. all the shells present in shells/ directory one by one. The shells are numbered and are run in ascending order by name. You can add your own shells to the directory. Ideally the `install.sh` should be idempotent and hence, all the constituent shells should be too, so if you're adding a shell, make sure it is idempotent and handles edge cases gracefully. Inside any shell script, you have access to some of the common environment variables defined in `install.sh`. Again, you can add to it for your own version.

Some of most commonly used shells are
  + mac os
  + homebrew
  + repo setup
  + mackup (used for syncing all the dotfiles, best way to do this really)
  + extra installations

All installations should be done through either brew, cask, or through a custom sh.
If you ever deviate from these methods(don't use install.sh) then that application won't be replicated automatically in a new machine. Such a list can be maintained separately in `config/extras.txt`.

## Mackup
### What is mackup ?
Here we are syncing everything from aliases, to mackup config itself, to ST3 config, iterm2 config etc.
### How is mackup being used ?
the file storage option is used and all the mackup data is synced to .hallows folder in local storage.
Then the local folder .hallows is kept in sync with .hallows in the setup repo(this repo itself) which is synced with github. This is being done with following 2 aliases. These aliases are contextual and
```
alias sync_setup='cd ~/Development/setup && git co personal/kashyap && mackup backup && cp -r ~/.hallows/ ~/Development/setup/.hallows'
alias push_setup='cd ~/Development/setup && git co personal/kashyap && git add . && git ci -m "update mackup" && git ps'
```
Before running the shell `04-mackup.sh` the first time,  you need to create a backup of your config by running the `mackup backup` command and copy it to the respective destination(in this case ~/.hallows). This is something that you will most likely setup differently.

The essence of mackup shell is to install mackup, restore the mackup from a remote location(in this case a directory in the setup repo itself).
### How to setup your own version for mackup ?
If you choose to go with the file system version then just update the config in install.sh

### How is the single command installation setup ?
Just added 2 things to this repo,
+ the actual command for installation in index.sh.
+ now.json & nowignore for setting up deployment to now
  + index.sh is served on setup.vkashyap.now.sh