#!/bin/bash

source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

CURRENT_SCRIPT_DIR=$REPOROOT/bash
BASH_DIR=$HOME/.config/bash
DEST_DIR="$HOME/Pictures/Wallpapers"
DEST_PATH="$DEST_DIR/$FILENAME"

# Download and setup wallpaper
# Usage:
#   install_wallpaper [-y]
install_bash() {
	info "Installing bash configuration..."
	create_symlink $HOME/.bashrc $CURRENT_SCRIPT_DIR/bashrc.sh $1

	create_symlink $BASH_DIR/utils/tracing.sh $CURRENT_SCRIPT_DIR/utils/tracing.sh $1
	create_symlink $BASH_DIR/utils/load.sh $CURRENT_SCRIPT_DIR/utils/load.sh $1

	create_symlink $BASH_DIR/configs/bindings.sh $CURRENT_SCRIPT_DIR/configs/bindings.sh $1
	info "Succesfully installed bash configuration"
}
