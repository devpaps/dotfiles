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
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Completion configuration
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# autoload -Uz compinit
# if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
#     compinit
# else
#     compinit -C
# fi
#
# zstyle ':completion:*' file-list all
# zstyle ':completion:*:*:*:*:*' menu select

# FZF key bindings
source <(fzf --zsh)

#-------------------------------------------------------------------------------
# Aliases
#-------------------------------------------------------------------------------
alias icat="kitty +kitten icat"
alias vz='NVIM_APPNAME=nvim-lazy nvim'  # LazyVim
alias v="nvim"                          # New nvim config
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons -lh --group-directories-first"
alias lla="eza --icons -lah"
alias lsd="eza --group-directories-first"
alias la="eza -a"
alias tn="tmux new -s"
alias tl="tmux ls"
alias ta="tmux attach -t"
alias cdi='zi'
alias tree='eza --tree --level=2'
alias cd='z'

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
alias dot="v $HOME/.dotfiles"
alias zsh="v $HOME/.zshrc"
export FZF_CTRL_T_OPTS="--preview 'if [ -d {} ]; then tree -C {} | head -200; else ~/fzf-preview.sh {}; fi' --height=100% --bind page-up:preview-page-up,page-down:preview-page-down"

# cdi shortcut for zoxide with fzf preview
export _ZO_FZF_OPTS="
  --preview 'eza --tree --level=2 --color=always {2..}'
  --preview-window=right:50%
  --height=100%
  --bind page-up:preview-page-up,page-down:preview-page-down
"

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

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
eval "$(fnm env --use-on-cd --shell zsh)"

# Starship prompt
eval "$(starship init zsh)"

#zoxide
eval "$(zoxide init zsh)"

#todo
export TODO_CUSTOM_FILE_PATH="$HOME/todos/todo.txt"

# Switch git accounts
alias switchgh="/home/devpaps/.dotfiles/git/switch-user.sh"

# opencode
# export PATH=/home/devpaps/.opencode/bin:$PATH

# GoLang
export PATH=$PATH:$HOME/go/bin

#Maven and Java
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export PATH="$JAVA_HOME/bin:$PATH"

# ARCHIVE EXTRACTION
# usage: ex <file>
function ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)    tar xjf $1    ;;
      *.tar.gz)     tar xzf $1    ;;
      *.tar.xz)     tar xf $1     ;;
      *.tar)        tar xf $1     ;;
      *.tar.zst)    uzstd $1      ;;
      *.bz2)        bunzip2 $1    ;;
      *.rar)        unrar x $1    ;;
      *.gz)         gunzip $1     ;;
      *.tbz2)       tar xjf $1    ;;
      *.tgz)        tar xzf $1    ;;
      *.zip)        unzip $1      ;;
      *.Z)          uncompress $1 ;;
      *.7z)         7z x $1       ;;
      *.deb)        ar x $1       ;;
      *)    echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Show aliases with fzf, i'm old :D
function show-aliases() {
    selected=$(grep "^alias " ~/.zshrc | fzf)
    if [ -n "$selected" ]; then
        zle -U "$(echo "$selected" | cut -d'=' -f2- | cut -d'#' -f1 | tr -d '"' | xargs)"
    fi
}

# Bind the function to a key combination (Ctrl+Z followed by Ctrl+A)
zle -N show-aliases
bindkey '^Z^A' show-aliases

# opencode
export PATH=/home/devpaps/.opencode/bin:$PATH

# Lerd
export PATH="/home/devpaps/.local/share/lerd/bin:$PATH"

# Lerd completions
fpath=(/home/devpaps/.local/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit
