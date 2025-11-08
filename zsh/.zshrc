#-------------------------------------------------------------------------------
# Base ZSH Configuration
#-------------------------------------------------------------------------------
HISTFILE="${HOME}/.config/.histfile"
export HISTSIZE="100000"
export HISTFILESIZE="200000"
export SAVEHIST="${HISTSIZE}"
setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS 
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Completion configuration
zstyle :compinstall filename '/home/devpaps/.zshrc'
autoload -Uz compinit
compinit

# FZF key bindings
source <(fzf --zsh)

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
alias icat="kitty +kitten icat"
alias vz='NVIM_APPNAME=nvim-lazy nvim'  # LazyVim
alias v="nvim"                          # New nvim config
alias ls="eza"
alias ll="eza -l"
alias lla="eza -la"
alias lsd="eza --group-directories-first"
alias la="eza -a"
# alias rf="fzf ${FZF_CTRL_R_OPTS}"
# alias pf="fzf ${FZF_CTRL_T_OPTS}"

#-------------------------------------------------------------------------------
# Environment Variables
#-------------------------------------------------------------------------------
export EDITOR="nvim"
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# Source secrets file if it exists
[ -f "$HOME/.dotfiles/zsh/.zsh_secrets" ] && source "$HOME/.dotfiles/zsh/.zsh_secrets"

#-------------------------------------------------------------------------------
# Shortcuts
# -------------------------------------------------------------------------------
# Shortcut to dotfiles
alias dt="v $HOME/.dotfiles"
alias zs="v $HOME/.zshrc"
# export FZF_CTRL_T_OPTS="--preview '(bat --height=100% --paging=never --color=always --style=plain --theme=base16 {} 2>/dev/null || tree -C {}) 2> /dev/null | head -200' --bind page-up:preview-page-up,page-down:preview-page-down"
# export FZF_CTRL_T_OPTS="--preview='less {}' --height=100% --bind page-up:preview-page-up,page-down:preview-page-down"
# export FZF_CTRL_T_OPTS="--preview '~/fzf-preview.sh {}' --height=100% --bind page-up:preview-page-up,page-down:preview-page-down"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then tree -C {} | head -200; else ~/fzf-preview.sh {}; fi' --height=100% --bind page-up:preview-page-up,page-down:preview-page-down"

#-------------------------------------------------------------------------------
# Path Configuration
#-------------------------------------------------------------------------------
# Ruby gems (user install) on PATH
export PATH="$HOME/bin:$PATH"

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
nvm use 22 >/dev/null 2>&1

# Starship prompt
eval "$(starship init zsh)"

#zoxide
eval "$(zoxide init zsh)"

#todo
export TODO_CUSTOM_FILE_PATH="$HOME/todos/todo.txt"

# Switch git accounts
alias switchgh="/home/devpaps/.dotfiles/git/switch-user.sh"

# opencode
export PATH=/home/devpaps/.opencode/bin:$PATH

# GoLang
export PATH=$PATH:$HOME/go/bin

#Maven and Java
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

