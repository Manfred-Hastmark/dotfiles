source "$REPOROOT/utils/tracing.sh"
source "$REPOROOT/utils/parse_yes_no.sh"
source "$REPOROOT/utils/download.sh"

# Download and install an AppImage to ~/.local
# Usage:
#   install_appimage [-y] <url>
#   -y or --yes: automatically overwrite existing files without prompting
install_appimage() {
    local auto_yes=0
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

    url="${args[0]}"

    if [[ -z "$url" ]]; then
        error "Missing arguments. Usage: install_appimage [-y] <url>"
        return 1
    fi

    local appimage_name
    appimage_name=$(basename "$url")
    local temp_dir="${TMPDIR:-/tmp}/appimage_$$"
    local dest="$temp_dir/$appimage_name"

    mkdir -p "$temp_dir" || {
        error "Failed to create temp directory: $temp_dir"
        return 1
    }

    [[ $auto_yes -eq 1 ]] && local yes_flag="-y" || local yes_flag=""
    download_file $yes_flag "$dest" "$url" || return 1
    (
        info "Extracting appimage..."
        cd "$temp_dir"
        chmod u+x "$appimage_name"
        ./"$appimage_name" --appimage-extract || {
            error "Not able to extract $dest"
            return 1
        }
        info "Extracted to: $temp_dir/squashfs-root"
    ) || return 1

    cp -r "$temp_dir/squashfs-root/usr/"* "$HOME/.local" || {
        error "Failed to copy files to $HOME/.local"
        return 1
    }
    rm -rf "$temp_dir"
    info "Installed appimage to: $HOME/.local"
}
