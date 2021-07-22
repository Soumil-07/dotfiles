export PATH=$HOME/bin:/usr/local/bin:$PATH
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=1000
export SAVEHIST=1000

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"

. "$HOME/.cargo/env"
export RIPGREP_CONFIG_PATH="~/.ripgreprc"


if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi
export PATH="/opt/homebrew/bin:$PATH"
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/bin/scripts:$PATH"
