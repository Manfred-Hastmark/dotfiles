source "$REPOROOT/utils/symlink.sh"
source "$REPOROOT/utils/tracing.sh"

# Install bash configuration
# Usage:
#   install_bash [-y]
install_bash() {
	local script_dir=$REPOROOT/bash
	local bash_dir=$HOME/.config/bash

	info "Installing bash configuration..."
	create_symlink $1 $HOME/.bashrc $script_dir/bashrc.sh || return 1

	create_symlink $1 $bash_dir/utils/tracing.sh $script_dir/utils/tracing.sh || return 1
	create_symlink $1 $bash_dir/utils/load.sh $script_dir/utils/load.sh || return 1

	create_symlink $1 $bash_dir/configs/bindings.sh $script_dir/configs/bindings.sh || return 1
	create_symlink $1 $bash_dir/configs/mods.sh $script_dir/configs/mods.sh || return 1
	create_symlink $1 $bash_dir/configs/variables.sh $script_dir/configs/variables.sh || return 1
	create_symlink $1 $bash_dir/configs/tmux.sh $script_dir/configs/tmux.sh || return 1

	info "Succesfully installed bash configuration"
    return 0
}
