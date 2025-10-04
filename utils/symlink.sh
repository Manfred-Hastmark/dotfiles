#!/usr/bin/bash

# Create a symlink from source to destination
# Usage:
#   create_symlink [-y] <destination_path> <source_path>
#   -y or --yes: overwrite existing file/symlink without prompting
create_symlink() {
    local auto_yes=0
    local dest=""
    local src=""

    # Parse args
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -y|--yes)
                auto_yes=1
                shift
                ;;
            -*)
                error "Unknown option: $1"
                return 1
                ;;
            *)
                if [[ -z "$dest" ]]; then
                    dest="$1"
                elif [[ -z "$src" ]]; then
                    src="$1"
                else
                    error "Unexpected argument: $1"
                    return 1
                fi
                shift
                ;;
        esac
    done

    # Validate args
    if [[ -z "$dest" || -z "$src" ]]; then
        error "Missing arguments. Usage: create_symlink [-y] <destination_path> <source_path>"
        return 1
    fi

    if [[ ! -e "$src" ]]; then
        error "Source file does not exist: $src"
        return 1
    fi

    # Check if destination exists
    if [[ -e "$dest" || -L "$dest" ]]; then
        if [[ "$auto_yes" -eq 1 ]]; then
            info "Destination '$dest' exists and will be overwritten (auto yes)."
            rm -rf "$dest" || {
                error "Failed to remove existing destination: $dest"
                return 1
            }
        else
            warn "Destination '$dest' already exists."
            read -rp "Overwrite? (y/n): " choice
            case "$choice" in
                y|Y)
                    info "Overwriting existing destination..."
                    rm -rf "$dest" || {
                        error "Failed to remove existing destination: $dest"
                        return 1
                    }
                    ;;
                n|N)
                    info "Aborting symlink creation."
                    return 0
                    ;;
                *)
                    warn "Invalid input. Aborting."
                    return 1
                    ;;
            esac
        fi
    fi

    # Create parent directory for destination if needed
    local dest_dir
    dest_dir=$(dirname "$dest")
    if [[ ! -d "$dest_dir" ]]; then
        info "Creating directory: $dest_dir"
        mkdir -p "$dest_dir" || {
            error "Failed to create directory: $dest_dir"
            return 1
        }
    fi

    # Create the symlink
    ln -s "$src" "$dest" && info "Symlink created: $dest -> $src" || {
        error "Failed to create symlink: $dest -> $src"
        return 1
    }
}

