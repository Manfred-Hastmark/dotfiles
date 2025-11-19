# Check that tracing functions exists
# Usage:
#   tracing_exists
tracing_exists() {
    if ! declare -F info warn error  &> /dev/null; then
        echo "Missing info trace functions"
        return 1
    fi
    return 0
}

# Checks that tmux exists
# Usage:
#   tmux_exists
tmux_exists() {
    if ! command -v tmux &> /dev/null; then
        error "Missing tmux"
        return 1
    fi
    return 0
}

# Check that all preconditons for setting up tmux are met
# Usage:
#   preconditions
preconditions() {
    tracing_exists || return 1
    tmux_exists || return 1
}

# Checks if tmux has given session
# Usage:
#   has_session <name>
has_session() {
    local name="$1"
    if [[ -z "$name" ]]; then
        warn "Missing arguments. Usage: has_session <name>"
        return 0
    fi
    if tmux has-session -t "$1" 2>/dev/null; then
        return 0
    fi
    return 1
}

# Checks if tmux has any sessions
# Usage:
#   has_any_sessions
has_any_sessions() {
    if tmux list-sessions &> /dev/null; then
        return 0
    fi
    return 1
}

# Check if session has given window
# Usage:
#   has_window <session> <name>
has_window() {
    local session="$1"
    local window="$2"

    if [[ -z "$session" || -z "$window" ]]; then
        error "Missing arguments. Usage: has_window <session> <name>"
        return 1
    fi

    if ! has_session "$session"; then
        return 1
    fi

    if tmux list-windows -t "$session" | grep "$window" &> /dev/null; then
        return 0
    fi
    return 1
}

# Checks if current terminal is running in TMUX
# Usage:
#   in_tmux
in_tmux() {
    if [[ -n "$TMUX" ]]; then
        return 0 
    fi
    return 1
}

# Creates window in a given session
# Usage:
#   create_window <window> <session> <directory> <args>
create_window() {
    local window="$1"
    local session="$2"
    local dir="$3"

    if [[ -z "$window" || -z "$session" || -z "$dir" ]]; then
        error "Missing arguments. Usage: create_window <window> <session> <directory>"
        return 1
    fi

    if ! [[ -d "$dir" ]]; then
        warn "Supplied directory; $dir is not a valid directory, creating directory"
        if ! mkdir -p "$dir"; then
            error "Failed to create directory; $dir, skipping create of window; $window"
            return 1
        fi
    fi

    if ! has_session "$session"; then
        warn "Missing session; $session when creating window; $window"
        return 1
    fi

    if has_window "$session" "$window"; then
        return 0
    fi

    if ! tmux new-window -t "$session" -n "$window" -c "$dir" -d -- "${@:4}"; then
        warn "Failed to create new window; $window in session; $session"
        return 1
    fi
    return 0
}

# Creates a new tmux sesion
# Usage:
#   create_session <session> <directory> <default-window>
create_session() {
    local session="$1"
    local dir="$2"
    local def_window="$3"

    if [[ -z "$session" || -z "$dir" || -z "$def_window" ]]; then
        error "Missing arguments. create_session <session> <directory> <default-window>"
        return 1
    fi

    if ! [[ -d "$dir" ]]; then
        warn "Supplied directory; $dir is not a valid directory, creating directory"
        if ! mkdir -p "$dir"; then
            error "Failed to create directory; $dir, skipping create of session; $session"
            return 1
        fi
    fi

    if has_session $session; then
        return 0
    fi

    if ! tmux new-session -d -s "$session" -n "$def_window" -c "$dir"; then
        warn "Not able to create session; $session"
        return 1
    fi
    return 0
}

# Creates a session with a terminal and editor windows
# Usage:
#   create_code_session <session> <directory>
create_code_session() {
    local session="$1"
    local dir="$2"
    create_session "$session" "$dir" terminal || return 1
    create_window editor "$session" "$dir" || return 1
    return 0
}

# Creates utils session with terminal, notes page and calculator
# Usage:
#   create_utils_session
create_utils_session() {
    local session="utils"
    create_session "$session" "$HOME" default || return 1
    create_window amazonq "$session" "$HOME" qchat || return 1
    create_window calculator "$session" "$HOME" python || return 1
    create_window notes "$session" "$HOME/Documents/notes" || return 1
    return 0
}

startup() {
    preconditions || return 1

    if in_tmux; then
        return 0
    fi

    create_code_session cmake-teensy $HOME/Documents/cfs/cmake-teensy
    create_code_session learning-rust $HOME/Documents/rust/learning-rust
    create_code_session dotfiles $HOME/Documents/dotfiles
    create_utils_session

    if ! has_any_sessions; then
        error "tmux does not have any sessions"
        return 1
    fi
    tmux attach
    return 0
}

startup
