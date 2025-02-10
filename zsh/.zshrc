#-------------------------------------------------------------------------------
# Base ZSH Configuration
#-------------------------------------------------------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Completion configuration
zstyle :compinstall filename '/home/devpaps/.zshrc'
autoload -Uz compinit
compinit

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
alias icat="kitty +kitten icat"
alias vz='NVIM_APPNAME=nvim-lazy nvim'  # LazyVim
alias v="nvim"                          # New nvim config

#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------
export EDITOR="v"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# Source secrets file if it exists
[ -f "$HOME/.dotfiles/zsh/.zsh_secrets" ] && source "$HOME/.dotfiles/zsh/.zsh_secrets"

#-------------------------------------------------------------------------------
# Path Configuration
#-------------------------------------------------------------------------------
# pnpm
export PNPM_HOME="/home/devpaps/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Additional PATH configurations
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

#-------------------------------------------------------------------------------
# Tool Configurations
#-------------------------------------------------------------------------------
# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Starship prompt
eval "$(starship init zsh)"
