source "$REPOROOT/utils/download.sh"
source "$REPOROOT/utils/tracing.sh"


# Download and setup wallpaper
# Usage:
#   install_wallpaper [-y]
install_wallpaper() {
    local url="https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/os/debian-black-4k.png"
    local dest="$HOME/Pictures/Wallpapers/wallpaper.png"

	info "Installing wallpaper..."
	download_file "$dest" $url $1 || return 1
	feh --bg-fill "$dest"
	info "Succesfully installed wallpaper"
    return 0
}
