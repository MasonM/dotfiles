ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mason"
DISABLE_AUTO_UPDATE="true"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh
KEYTIMEOUT=1
unsetopt hist_ignore_dups
setopt hist_find_no_dups
setopt nosharehistory
bindkey '^r' history-incremental-search-backward
alias ack=ack-grep
unsetopt correctall

