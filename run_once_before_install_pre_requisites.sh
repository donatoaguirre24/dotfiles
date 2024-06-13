#!/usr/bin/env zsh

set -eu

# Install Hombrew if it's not already installed
if ! command -v brew >/dev/null; then
  echo "Installing Hombrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Install Mise if it's not already installed
if ! command -v mise >/dev/null; then
  echo "Installing Mise"
  curl https://mise.run | sh
fi

# Install Zap if it's not already installed
ZAP_FUNCTION="$HOME/.local/share/zap/zap.zsh"

if [ -f $ZAP_FUNCTION ]; then
  source $ZAP_FUNCTION

  if ! command -v zap >/dev/null; then
    echo "Installing Zap"
    zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) -k -b release-v1
  fi
fi
