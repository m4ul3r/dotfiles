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
export BINARYNINJADIR=/opt/binaryninja

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

# fzf keybindings and completion (CTRL-T: files, CTRL-R: history, ALT-C: cd)
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

alias ls="eza"
alias rp="realpath"
alias vim="nvim"
alias open="xdg-open"

alias cy="CLAUDE_CODE_NO_FLICKER=1 claude --dangerously-skip-permissions"
alias cyt="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 cy"
alias clanker="CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 cy"

alias goblin="codex --yolo"

# sshfs: beelink-home:/media/ssd/brain <-> /mnt/brain
mount-brain() {
  [[ -d /mnt/brain ]] || sudo mkdir -p /mnt/brain
  [[ -O /mnt/brain ]] || sudo chown "$USER:$USER" /mnt/brain
  if mountpoint -q /mnt/brain; then
    echo "/mnt/brain already mounted"
    return 0
  fi
  sshfs beelink-home:/media/ssd/brain /mnt/brain \
    -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3
}

umount-brain() {
  if ! mountpoint -q /mnt/brain; then
    echo "/mnt/brain not mounted"
    return 0
  fi
  fusermount3 -u /mnt/brain
}

# omarchy tmux dev layout
source ~/.local/share/omarchy/default/bash/fns/tmux

. "$HOME/.local/share/../bin/env"

# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<
