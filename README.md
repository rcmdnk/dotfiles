dotfiles
========

**Setting files for bash**

## Installation

Below commands will make links to dotfiles in $HOME directory

    cd ~/tmp
    git clone git@github.com:rcmdnk/dotfiles
    cd dotfiles
    ./install.sh

Existing files are replaced without backup by default.
Use `-b <postfix>` to keep them as backups (e.g. `./install.sh -b bak` makes `*.bak`).
Existing directories (not links) are skipped unless `-b` is given.

Other options (see `./install.sh -h`):

    -n  Don't overwrite if file is already exist
    -d  Dry run, don't install anything
    -c  Copy files, instead of making links
    -i  Set install directory (default: $HOME)
