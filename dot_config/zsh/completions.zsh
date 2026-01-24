#!/usr/bin/env zsh

# Add brew binaries completions
if [[ -v commands[brew] ]]; then
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

# Add third party site-functions directory to the FPATH (e.g. chezmoi, docker, etc.)
local THIRD_PARTY_SITE_FUNCTIONS="$XDG_DATA_HOME/zsh/site-functions"

if [[ -d "$THIRD_PARTY_SITE_FUNCTIONS" ]]; then
  fpath+="$THIRD_PARTY_SITE_FUNCTIONS"
fi

autoload -Uz compinit

# Only rebuild the completion dump if it's older than 12 hours to speed up shell startup
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+12) ]]; then
  compinit -d "$ZDOTDIR/.zcompdump"
else
  compinit -C -d "$ZDOTDIR/.zcompdump"
fi

# Completion styling
local PREVIEW_COMMAND='lsd --almost-all --color=always --icon=always $realpath'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'         # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"        # Enable filename colorizing
zstyle ':completion:*' menu no                                 # Disable menu completion
zstyle ':fzf-tab:complete:cd:*' fzf-preview "$PREVIEW_COMMAND" # Use lsd to preview contents
zstyle ':fzf-tab:complete:z:*' fzf-preview "$PREVIEW_COMMAND"  # Complete Zoxide's paths
zstyle ':fzf-tab:*' switch-group '<' '>'                       # Use arrows to switch between groups
