# Bash setup with fzf, reverse-i-search for e.g.
fzf_bash() {
	export FZF_DEFAULT_OPTS="--bind 'tab:up,shift-tab:down'"
	eval "$(fzf --bash)"
}
fzf_bash
