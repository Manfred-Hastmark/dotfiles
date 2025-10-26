source "$REPOROOT/utils/tracing.sh"
source "$REPOROOT/utils/parse_yes_no.sh"

# Clones a repository to a given directory
# Usage:
#   clone_repo [-y] <dest> <url>
clone_repo() {
    local auto_yes=0
    local dest=""
    local url=""
    local args=()
    
    # -------------------------------
    # Parse arguments
    # -------------------------------
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -y|--yes)
                auto_yes=1
                shift
                ;;
            --) # end of options
                shift
                break
                ;;
            -*)
                echo "Unknown option: $1"
                return 1
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done

    # Remaining positional arguments after options
    # Append any arguments after "--" if present
    args+=("$@")

    # Assign destination and url
    dest="${args[0]}"
    url="${args[1]}"

    # Validate args
    if [[ -z "$dest" || -z "$url" ]]; then
        error "Missing arguments. Usage: clone_repo [-y] <destination_path> <url>"
        return 1
    fi

    local dir
    dir=$(dirname "$dest")
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
            info "$dest exists — auto-overwrite enabled."
        else
            warn "Path already exists: $dest"
            if ! parse_yes_no "Do you want to overwrite it? (y/n): "; then
                info "Skipping download."
                return 0
            fi
            info "Overwriting existing file..."
        fi
    fi

    if git clone "$url" "$dest"; then
        info "Cloned to: $dest"
        return 0
    else
        error "Failed to clone from: $url"
        return 1
    fi
}
