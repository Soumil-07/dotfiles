# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/soumil/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit

prompt adam1
# End of lines added by compinstall

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

alias vim="nvim"
alias ls="ls -Fh --color=always"

eval "$(zoxide init zsh)"
