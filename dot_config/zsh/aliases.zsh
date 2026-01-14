#!/usr/bin/env zsh

# General
alias brewery='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
alias c='clear'
alias cdd='trash ~/Library/Developer/Xcode/DerivedData/*'
alias dotfiles="$VISUAL $(chezmoi source-path)"
alias reload="source $ZSHRC"
alias show_packages_size='du -sh ./node_modules/* | sort -nr | rg "\dM.*"'
alias show_path="tr ':' '\n' <<< \"$PATH\""
alias show_path_expanded='print -l $path' # Like show_path, but with ZSH hooks applied
alias speedtest='networkQuality'
alias update_all='zap update all && chezmoi upgrade && mise self-update --yes && brewery'

# Bat
if [[ -v commands[bat] ]]; then
  alias cat='bat'
fi

# FZF
if [[ -v commands[fd] ]]; then
  alias find='fd --type f --hidden --follow --exclude .git'
fi

# Docker
if [[ -v commands[docker] ]]; then
  alias dc=dc-fn # defined in functions.zsh
  alias dcu='docker compose up -d'
  alias dcd='docker compose down --remove-orphans'
  alias dcr=dcr-fn # defined in functions.zsh
  alias dex=dex-fn # defined in functions.zsh
  alias dps='docker ps'
  alias dpsa='docker ps -a'
fi

# Lazygit
if [[ -v commands[lazygit] ]]; then
  alias lg='lazygit'
fi

# LSD
if [[ -v commands[lsd] ]]; then
  alias ls='lsd'
  alias ll='lsd --almost-all --oneline'
  alias la='lsd --almost-all --long'
  alias tree='lsd --tree --depth=2'
fi

# Trash
if [[ -v commands[trash] ]]; then
  alias rm='trash'
fi

# Zoxide
if [[ -v commands[zoxide] ]]; then
  alias cd='z'
fi
