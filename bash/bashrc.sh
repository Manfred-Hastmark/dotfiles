BASH_CONF_DIR=$HOME/.config/bash
BASH_UTILS_DIR=$BASH_CONF_DIR/utils
BASH_CONFIGS_DIR=$BASH_CONF_DIR/configs

if [[ ! -e "$BASH_UTILS_DIR/tracing.sh" ]]; then
	echo "Could not find $BASH_UTILS_DIR/tracing.sh"
	return 1
fi
source $BASH_UTILS_DIR/tracing.sh

if [[ ! -e "$BASH_UTILS_DIR/load.sh" ]]; then
	error "Could not find $BASH_UTILS_DIR/load.sh"
	return 1
fi
source $BASH_UTILS_DIR/load.sh

load_config_file "$BASH_CONFIGS_DIR/bindings.sh" || return
load_config_file "$BASH_CONFIGS_DIR/mods.sh" || return

info "Welcome!"
