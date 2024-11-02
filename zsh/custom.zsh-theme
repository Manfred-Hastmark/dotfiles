# Set up color variables using Catppuccin Mocha color palette
# Feel free to adjust these color codes to better match your preferences
FG_GRAY="%{$fg_bold[gray]%}"            # Path color (now set to gray)
FG_GREEN="%{$fg[green]%}"                # Arrow color
FG_GIT="%{$fg[magenta]%}"                # Git info color
FG_DIRTY="%{$fg[red]%}"                  # Git dirty status color
FG_CLEAN="%{$fg[green]%}"                # Git clean status color

# Define the main prompt
PROMPT="${FG_GRAY}%~ ${FG_GRAY}%{$reset_color%}
${FG_GREEN}➞  %{$reset_color%}"

# Git info on the right prompt
RPROMPT='$(git_prompt_info)'

# Git prompt configurations
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="${FG_GIT}] ${FG_DIRTY}✖ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="${FG_GIT}] ${FG_CLEAN}✔ %{$reset_color%}"

# Optional: Disable the ruby prompt if you're not using Ruby
ZSH_THEME_RPROMPT=''
