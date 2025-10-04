#!/usr/bin/bash

REPOROOT=$(git rev-parse --show-toplevel)

source $REPOROOT/wallpaper/install.sh

install_wallpaper $1
