#!/usr/bin/bash

REPOROOT=$(git rev-parse --show-toplevel)

source $REPOROOT/wallpaper/install.sh
source $REPOROOT/bash/install.sh

auto_yes=$1

install_wallpaper $auto_yes
install_bash $auto_yes
