#!/usr/bin/bash

# Load a bash file with configurations
# Usage:
#   load_config_file <source-path>
# Precondition:
#   tracing.sh has been loaded
load_config_file() {
	local src=$1
    	if [[ -z "$src" ]]; then
		error "Missing source-path, usage: load_config_file <source-path>"
		return 1
	fi

    	if [[ ! -e "$src" ]]; then
		error "Source file does not exist: $src"
		return 1
	fi
	source $src
	return 0
}
