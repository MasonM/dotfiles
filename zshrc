ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mason"
# Disable this for performance: https://github.com/ohmyzsh/ohmyzsh/issues/9055#issuecomment-1049812446
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"
# https://github.com/ohmyzsh/ohmyzsh/blob/e0c6cb147030350c8e27dbdeda6e8a4d367d1e66/plugins/vi-mode/README.md#settings
VI_MODE_DISABLE_CLIPBOARD=true
plugins=(git docker vi-mode)
source $ZSH/oh-my-zsh.sh
KEYTIMEOUT=1
unsetopt hist_ignore_dups
setopt hist_find_no_dups
setopt nosharehistory
unsetopt correctall
eval "$(atuin init --disable-up-arrow zsh)"
