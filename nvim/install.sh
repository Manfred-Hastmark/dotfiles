source "$REPOROOT/utils/appimage.sh"
source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

install_nvim() {
	local script_dir=$REPOROOT/nvim

	info "Install neovim..."
    local url="https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage"
    install_appimage $1 "$url" || retun 1
	info "Installed neovim"
    
	info "Install neovim configuration..."
	create_symlink $HOME/.config/nvim $script_dir/configs $1 || return 1
	info "Succesfully installed neovim configuration"
    return 0
}
