#!/usr/bin/env zsh

# General
alias brewery="brew update && brew upgrade && brew upgrade --cask && brew cleanup"
alias c="clear"
alias dotfiles="cursor $(chezmoi source-path)"
alias reload="source $ZSHRC"
alias show_packages_size="du -sh ./node_modules/* | sort -nr | rg '\dM.*'"
alias show_path="tr ':' '\n' <<< \"$PATH\""
alias speedtest="networkQuality"
alias update_all="zap update all && chezmoi upgrade && mise self-update --yes && brewery"

# Mobile Development
alias boot_emulator="emulator @Pixel_8_API_34 -no-boot-anim -no-snapshot -dns-server 8.8.8.8"
alias boot_simulator="xcrun simctl boot E87FC0D4-12FB-494E-99D8-2A7F4D7CB91C && open -a Simulator"
alias cdd="trash ~/Library/Developer/Xcode/DerivedData/*"

# FZF
if [[ -v commands[fd] ]]; then
  alias find="fd --type f --hidden --follow --exclude .git"
fi

# LSD
if [[ -v commands[lsd] ]]; then
  alias ls='lsd'
  alias ll='lsd -1A'
  alias la='lsd -lA'
  alias tree='lsd -l --tree --depth=2'
fi

# Trash
if [[ -v commands[trash] ]]; then
  alias rm="trash"
fi

# Zoxide
if [[ -v commands[zoxide] ]]; then
  alias cd='z'
fi
