#!/usr/bin/bash

REPOROOT=$(git rev-parse --show-toplevel)

source $REPOROOT/wallpaper/install.sh
source $REPOROOT/font/install.sh
source $REPOROOT/alacritty/install.sh
source $REPOROOT/bash/install.sh
source $REPOROOT/nvim/install.sh
source $REPOROOT/tmux/install.sh

auto_yes=$1
install_wallpaper $auto_yes || exit 1
install_font $auto_yes || exit 1
install_alacritty $auto_yes || exit 1
install_bash $auto_yes || exit 1
install_nvim $auto_yes || exit 1
install_tmux $auto_yes || exit 1

source $HOME/.bashrc
