#!/bin/bash

set -eufo pipefail

echo "🚀 Bootstrapping dotfiles"

if xcode-select -p &> /dev/null; then
  echo "✅ Xcode command line tools are already installed"
else
  echo "🔧 Installing Xcode command line tools"
  xcode-select --install &> /dev/null
  echo "✅ Xcode command line tools installed successfully"
fi

if which -s "brew"; then
  echo "✅ Homebrew is already installed"
else
  echo "🍺 Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  echo "✅ Homebrew installed successfully"
fi

if [ -f "$HOME/.local/share/zap/zap.zsh" ]; then
  echo "✅ Zap is already installed"
else
  echo "⚡ Installing Zap"
  zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) -k -b release-v1
  echo "✅ Zap installed successfully"
fi
