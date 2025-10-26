# Checks if tmux has given session
# Usage:
#   has_session <name>
has_session() {
    if tmux has-session -t "$1" 2>/dev/null; then
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

# Creates a session with a terminal and editor windows
# Usage:
#   create_code_session <name> <directory>
create_code_session() {
    local sessionName="$1"
    local dir="$2"
    if has_session $sessionName; then
        return 1
    fi
    tmux new-session -n terminal -s "$sessionName" -c "$dir" -d
    tmux new-window -t "$sessionName" -n editor -c "$dir" -d nvim
    return 0
}

startup() {
    create_code_session dotfiles $HOME/Documents/proj/dotfiles
    if in_tmux; then
        return 0
    fi

    if has_session default; then
        tmux attach-session -t default
        return 0
    fi
    tmux new-session -s default
    return 0
}

startup
