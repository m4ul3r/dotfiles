# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="crunch"

plugins=(
    git
    colored-man-pages
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.nimble/bin:$HOME/.local/bin

# rust
source "$HOME/.cargo/env"

# aliases
alias apt="nala"
alias binja="/opt/binaryninja/binaryninja"
alias rp="realpath"
alias ipy="ipython3"
