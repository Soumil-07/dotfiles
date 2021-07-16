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
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi
FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/usr/local/bin/scripts:$PATH"
