source "$REPOROOT/utils/tracing.sh"
source "$REPOROOT/utils/clone.sh"

install_tmux() {
	local script_dir=$REPOROOT/tmux
    local url="https://github.com/tmux-plugins/tpm"
    local dest="$HOME/.tmux/plugins/tpm"

    info "Installing tmux configuration..."
    clone_repo "$dest" "$url" $1 || return 1
    create_symlink $HOME/.config/tmux/tmux.conf $script_dir/tmux.conf $1 || return 1
    info "Installed tmux configuration"
}
