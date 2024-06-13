alias brewery="brew update && brew upgrade && brew upgrade --cask && brew cleanup"
alias c="clear"
alias cdd="trash ~/Library/Developer/Xcode/DerivedData/*"
alias dotfiles="code $(chezmoi source-path)"
alias gitconfig="code $HOME/.gitconfig"
alias reload="source $ZDOTDIR/.zshrc"
alias rm="trash"
alias show_packages_size="du -sh ./node_modules/* | sort -nr | rg '\dM.*'"
alias show_path="tr ':' '\n' <<< \"$PATH\""
alias speedtest="networkQuality"
alias zshconfig="code $ZDOTDIR/.zshrc"

function update_all() {
  # Update Zap packages
  zap update all

  # Update Chezmoi
  chezmoi upgrade

  # Update Mise
  mise self-update

  # Update Homebrew formulas and casks
  brewery
}
