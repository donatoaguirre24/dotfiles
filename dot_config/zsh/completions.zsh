#!/usr/bin/env zsh

# Add brew binaries completions
if (( $+commands[brew] )); then
  # If the 'HOMEBREW_PREFIX' environment variable is not populated then
  # request the prefix from 'brew' and populate it
  if [[ -z "$HOMEBREW_PREFIX" ]]; then
    export HOMEBREW_PREFIX="$(brew --prefix)"
  fi

  # Add Homebrew's site-functions directory to the FPATH
  local HOMEBREW_SITE_FUNCTIONS="$HOMEBREW_PREFIX/share/zsh/site-functions"

  if [[ -d "$HOMEBREW_SITE_FUNCTIONS" ]]; then
    fpath+="$HOMEBREW_SITE_FUNCTIONS"
  fi
fi

# Add third party site-functions directory to the FPATH (e.g. chezmoi, mise)
local THIRD_PARTY_SITE_FUNCTIONS="$XDG_DATA_HOME/zsh/site-functions"

if [[ -d "$THIRD_PARTY_SITE_FUNCTIONS" ]]; then
  fpath+="$THIRD_PARTY_SITE_FUNCTIONS"
fi

autoload -Uz compinit
compinit -d "$ZDOTDIR/.zcompdump"
