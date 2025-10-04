#!/bin/bash

source "$REPOROOT/utils/download.sh"
source "$REPOROOT/utils/tracing.sh"

URL="https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/os/debian-black-4k.png"
FILENAME="wallpaper.png"
DEST_DIR="$HOME/Pictures/Wallpapers"
DEST_PATH="$DEST_DIR/$FILENAME"

# Download and setup wallpaper
# Usage:
#   install_wallpaper [-y]
install_wallpaper() {
	info "Installing wallpaper..."
	mkdir -p "$DEST_DIR"
	download_file $DEST_PATH $URL $1
	feh --bg-fill "$HOME/Pictures/Wallpapers/wallpaper.png"
	info "Succesfully installed wallpaper"
}
