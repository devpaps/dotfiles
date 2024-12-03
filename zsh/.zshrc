alias icat="kitty +kitten icat"

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/devpaps/.zshrc'

autoload -Uz compinit
compinit
eval "$(starship init zsh)"

alias vz='NVIM_APPNAME=nvim-lazy nvim' # LazyVim

alias v="nvim" # New nvim config

export EDITOR="v"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/devpaps/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# composer
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
