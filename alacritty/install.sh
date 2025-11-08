source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

# Install alacritty configuration
# Usage:
#   install_alacritty [-y]
install_alacritty() {
	local script_dir=$REPOROOT/alacritty
    local config_path="$HOME/.config/alacritty"

    info "Installing alacritty configuration..."
	create_symlink $config_path/alacritty.toml $script_dir/alacritty.toml $1 || return 1
    info "Installed alacritty configuration"
    return 0
}
