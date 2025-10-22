source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

install_nvim() {
	local script_dir=$REPOROOT/nvim
	info "Install neovim configuration..."
	create_symlink $HOME/.config/nvim $script_dir/configs $1 || return 1
	info "Succesfully installed neovim configuration"
    return 0
}
