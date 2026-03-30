export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="crunch"

plugins=(
    colored-man-pages
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:$HOME/.nimble/bin:$HOME/.local/bin

# aliases
alias binja="/opt/binaryninja/binaryninja"
alias rp="realpath"
alias ipy="ipython3"
