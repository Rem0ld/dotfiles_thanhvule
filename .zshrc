export ZSH="$HOME/.oh-my-zsh"
export TERM="xterm-256color"
export EDITOR="nvim"
export BROWSER="brave"
export GOPATH="$HOME/Extra/go"
export NODE_PATH="$HOME/.npm-packages/lib/node_modules"
export PATH=$PATH:$GOPATH/bin:$HOME/.npm-packages/bin:$HOME/.cargo/bin:$HOME/.local/share/neovim/bin

ZSH_THEME=""

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"

plugins=(fast-syntax-highlighting zsh-completions zsh-autosuggestions zsh-autopair extract rust yarn)

source $ZSH/oh-my-zsh.sh

alias cat="bat"
alias sl="exa --icons --sort type -a --git"
alias ls="exa --icons --sort type -a --git"
alias ll="exa --icons --long --sort type -a --git"
alias l="exa --icons --long --sort type -a --git"
alias tree="exa --icons --git -a --tree -s type -I '.git|node_modules|bower_components'"
alias :q="exit"
alias :h="man"
alias cd..="cd .."
alias ..="cd .."
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias df="df -h"
alias rm="rm -ir"
alias open="xdg-open"
alias vim="nvim"
alias vi="\vim"
alias grep="rg"
alias find="fd"
alias ports="sudo lsof -i -P -n | grep LISTEN"

if [[ $XDG_SESSION_TYPE == 'x11' ]]; then
	alias copy="xclip -sel clip"
else
	alias copy="wl-copy"
fi

# bun completions
[ -s "/home/thanhvule0310/.bun/_bun" ] && source "/home/thanhvule0310/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
