#!/usr/bin/bash

# Parse -y / --yes flag from args
# Usage: parse_auto_yes "$@"
# Returns:
#   Sets global variable auto_yes=1 if -y/--yes is found, else 0
#   Echoes remaining arguments (without -y/--yes)
parse_auto_yes() {
    auto_yes=0
    remaining_args=()  # global array to store non -y/--yes args
    for arg in "$@"; do
        case "$arg" in
            -y|--yes) auto_yes=1 ;;
            *) remaining_args+=("$arg") ;;
        esac
    done
}

# Parse yes/no user input
# Usage: parse_yes_no "Prompt message"
# Returns 0 if yes, 1 if no or invalid input
parse_yes_no() {
    local prompt="${1:-Are you sure? (y/n): }"
    local input

    read -rp "$prompt" input
    case "$input" in
        y|Y|yes|YES|Yes)
            return 0
            ;;
        n|N|no|NO|No)
            return 1
            ;;
        *)
            warn "Invalid input. Please enter y or n."
            return 1
            ;;
    esac
}
