#!/usr/bin/bash

REPOROOT=$(git rev-parse --show-toplevel)

source "$REPOROOT/utils/tracing.sh"
source "$REPOROOT/utils/parse_yes_no.sh"

# Download a file to a destination path
# Usage: download_file "/path/to/file" "https://example.com/file.png"
# Download a file to a specified destination
# Usage:
#   download_file [-y] <destination_path> <url>
#   -y or --yes: automatically overwrite existing files without prompting
# Download a file to a specified destination
# Usage:
#   download_file [-y] <destination_path> <url>
#   -y or --yes: automatically overwrite existing files without prompting

download_file() {
    local auto_yes=0
    local dest=""
    local url=""

    # Parse auto_yes and strip it from args
    local args
    args=$(parse_auto_yes "$@")

    # Parse remaining positional args
    read -r dest url <<< "$args"

    # Validate args
    if [[ -z "$dest" || -z "$url" ]]; then
        error "Missing arguments. Usage: download_file [-y] <destination_path> <url>"
        return 1
    fi

    local dir
    dir=$(dirname "$dest")

    # Ensure destination directory exists
    if [[ ! -d "$dir" ]]; then
        info "Creating directory: $dir"
        mkdir -p "$dir" || {
            error "Failed to create directory: $dir"
            return 1
        }
    fi

    # Handle existing file
    if [[ -f "$dest" ]]; then
        if [[ "$auto_yes" -eq 1 ]]; then
            info "File exists at $dest — auto-overwrite enabled."
        else
            warn "File already exists: $dest"
            if ! parse_yes_no "Do you want to overwrite it? (y/n): "; then
                info "Skipping download."
                return 0
            fi
            info "Overwriting existing file..."
        fi
    fi

    # Download the file
    info "Downloading from $url..."
    if wget -q --show-progress -O "$dest" "$url"; then
        info "Downloaded to: $dest"
        return 0
    else
        error "Failed to download from: $url"
        return 1
    fi
}
