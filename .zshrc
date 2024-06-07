# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

alias vim='/home/hastmark/.local/bin/nvim/nvim.appimage'
alias nvim='/home/hastmark/.local/bin/nvim/nvim.appimage'
alias compdb='pio run --target compiledb --environment compdb --project-dir $(git rev-parse --show-toplevel)'


alias test_upload='platformio run -t upload --environment'
alias test_shit='pio run --target compiledb --environment compdb'
alias compdb='pio run --target compiledb --environment compdb --project-dir $(git rev-parse --show-toplevel)'
alias build='ls $(git rev-parse --show-toplevel)/src/nodes | fzf | xargs pio run --project-dir $(git rev-parse --show-toplevel) --environment'

alias upload='platformio run --project-dir $(git rev-parse --show-toplevel) -t upload --environment'
alias flash='ls $(git rev-parse --show-toplevel)/src/nodes | fzf | read node; pio run --project-dir $(git rev-parse --show-toplevel) --environment $node; node-patcher $node .pio/build/$node/firmware.hex'
alias monitor='platformio device monitor'

alias compile='pio run --environment test_linux'
alias run='./.pio/test_linux/program'

alias canSetup='sudo ip link set can0 type can bitrate 1000000'
alias canUp='sudo ip link set up can0'
alias savvy='sudo ip link set can0 type can bitrate 1000000; sudo ip link set up can0; /home/hastmark/Documents/SavvyCAN/SavvyCAN'

alias cppcheck='~/../../opt/cppcheckpremium/cppcheck'
alias compliance='~/../../opt/cppcheckpremium/compliance-report'
alias cppreport='~/Documents/cppcheck/htmlreport/cppcheck-htmlreport'
alias restore='git diff --name-only | fzf | xargs git restore'
alias diff='git diff --name-only | fzf | xargs git diff'
alias nf='cd /home/hastmark/Documents/CFS/software/node-firmware'

PATH="$PATH:/usr/bin/ikos/bin"
PATH="$PATH:/home/hastmark/Documents/CFS/software/node-patcher/bin"

# Created by `pipx` on 2024-05-15 14:26:34
export PATH="$PATH:/home/hastmark/.local/bin"
