source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

# Install bash configuration
# Usage:
#   install_bash [-y]
install_bash() {
	local script_dir=$REPOROOT/bash
	local bash_dir=$HOME/.config/bash

	info "Installing bash configuration..."
	create_symlink $HOME/.bashrc $script_dir/bashrc.sh $1 || return

	create_symlink $bash_dir/utils/tracing.sh $script_dir/utils/tracing.sh $1 || return
	create_symlink $bash_dir/utils/load.sh $script_dir/utils/load.sh $1 || return

	create_symlink $bash_dir/configs/bindings.sh $script_dir/configs/bindings.sh $1 || return
	create_symlink $bash_dir/configs/mods.sh $script_dir/configs/mods.sh $1 || return

	info "Succesfully installed bash configuration"
}
