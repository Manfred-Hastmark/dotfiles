source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

install_nvim() {
	local script_dir=$REPOROOT/nvim

	info "Install neovim..."
    local url="https://github.com/neovim/neovim/releases/download/v0.11.4/nvim-linux-x86_64.appimage"
    local appimage="nvim.appimage"
    local dest="$script_dir/.temp/$appimage"
	download_file "$dest" "$url" $1 || return 1
    (
        info "Extracting appimage..."
        cd "$script_dir/.temp"
        chmod u+x $appimage
        ./$appimage --appimage-extract
        if [[ $? -ne 0 ]]; then
            error "Not able to extract $dest"
            return 1
        fi
        info "Extracted to: $script_dir/.temp/squashfs-root"
    ) || return 1
    cp -r $script_dir/.temp/squashfs-root/usr/* $HOME/.local
    rm -rf $script_dir/.temp
    info "Installed neovim to: $HOME/.local"

	info "Install neovim configuration..."
	create_symlink $HOME/.config/nvim $script_dir/configs $1 || return 1
	info "Succesfully installed neovim configuration"
    return 0
}
