source "$REPOROOT/utils/download.sh"
source "$REPOROOT/utils/tracing.sh"


# Download and setup wallpaper
# Usage:
#   install_wallpaper [-y]
install_wallpaper() {
    local url="https://raw.githubusercontent.com/zhichaoh/catppuccin-wallpapers/main/os/debian-black-4k.png"
    local file="wallpaper.png"
    local dest_dir="$HOME/Pictures/Wallpapers"

	info "Installing wallpaper..."
	mkdir -p "$dest_dir"
	download_file "$dest_dir/$file" $url $1
	feh --bg-fill "$dest_dir/$file"
	info "Succesfully installed wallpaper"
}
