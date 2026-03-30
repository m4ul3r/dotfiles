export ZSH="$HOME/.oh-my-zsh"

ZSH_DISABLE_COMPFIX=true
ZSH_THEME="crunch"

plugins=(
	colored-man-pages
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh

# history settings
HISTSIZE=500000
SAVEHIST=500000
setopt SHARE_HISTORY        # share across sessions
setopt HIST_IGNORE_DUPS     # no duplicate entries
setopt HIST_IGNORE_SPACE    # ignore commands starting with space

binja() {
  /opt/binaryninja/binaryninja "$@" &
}

# zoxide - smarter cd (use 'z' to jump to directories)
export PATH="$HOME/.local/bin:$PATH"
eval "$(zoxide init zsh)"

# Completions (cached for faster startup)
fpath+=~/.zfunc
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select

# nim
export PATH=$HOME/.nimble/bin:$PATH

alias ls="eza"
alias rp="realpath"
alias vim="nvim"

alias cy="claude --dangerously-skip-permissions"
alias cyt="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 cy"
alias clanker="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 cy"

# omarchy tmux dev layout
source ~/.local/share/omarchy/default/bash/fns/tmux

. "$HOME/.local/share/../bin/env"
