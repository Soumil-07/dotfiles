# Show git branch in prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{208}%~%f${vcs_info_msg_0_} -> '

setopt AUTO_CD
setopt AUTO_PUSHD
setopt AUTO_MENU
setopt ALWAYS_TO_END
setopt CASE_GLOB
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt CORRECT
setopt NO_BEEP
setopt INC_APPEND_HISTORY
setopt NO_CORRECT

# Load aliases and shortcuts if they exist
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
[ -f "$HOME/.config/shortcutrc" ] && sed -E '/\#.*/d; s/(.*) (.*)/alias \1="cd \2"/' $HOME/.config/shortcutrc | source /dev/stdin

# Completion
autoload -U compinit; compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

autoload zmv
alias zcp='zmv -C'
alias mmv="noglob zmv -W"
function take() {
  mkdir -p $@ && cd ${@:$#}
}

# dotfiles repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# Autosuggestions
source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
