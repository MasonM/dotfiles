ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mason"
DISABLE_AUTO_UPDATE="true"
plugins=(git python vi-mode screen debian)
source $ZSH/oh-my-zsh.sh
bindkey -v
KEYTIMEOUT=1
unsetopt hist_ignore_dups
setopt hist_find_no_dups
setopt nosharehistory
#alias ack=ack-grep
unsetopt correctall
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
