source "$REPOROOT/utils/download.sh"
source "$REPOROOT/utils/tracing.sh"

# Install RobotoMono nerd font
# Usage:
#   install_font [-y]
install_font() {
    local url=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/RobotoMono.zip
    local dest="$HOME/.local/share/fonts/RobotoMono.zip"

    info "Installing font..."
	download_file "$dest" $url $1 || return 1
    unzip -oq "$dest" -d $(dirname "$dest") || return 1
    info "Installed font"
}
