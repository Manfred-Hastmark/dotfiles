# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export VIRTUAL_ENV_DISABLE_PROMPT=1

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="custom"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 3

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Always start tmux
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Source pip virtual environment
source .venv/bin/activate

# Aliases
alias vim='nvim'
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
alias cl='cd /home/hastmark/Documents/CFS/software/cfs-imgui-client'
alias fcd='cd $(fzf-folder)'

alias prep='git restore . --patch'
alias merge='git mergetool --tool=nvimdiff'

PATH="$PATH:/home/hastmark/Documents/CFS/software/node-patcher/bin:/home/hastmark/Documents/projects/fzf-folder/out"
export PATH="$PATH:/home/hastmark/.local/bin"
export PATH="$PATH:/home/hastmark/bin"
export NVIM_NODE_HOST="npm"
export PATH="/home/hastmark/.pixi/bin:$PATH"
eval "$(pixi completion --shell zsh)"
