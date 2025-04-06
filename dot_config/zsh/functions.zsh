# AWS profile management
awsp() {
  if [ -z "$1" ]; then
    echo "Usage: awsp [open|list]"
    return 1
  fi

  if [ "$1" = "open" ]; then
    cursor "$HOME/.aws/config"
    return
  fi

  if [ "$1" = "list" ]; then
    grep -E '^\[profile' ~/.aws/config | sed 's/^\[profile //; s/\]//'
    return
  fi
}

# Force rebuild ZSH completions
rebuild-completions() {
  rm "$ZDOTDIR/.zcompdump"
  compinit -d "$ZDOTDIR/.zcompdump"
  echo "Completions rebuilt!"
}

# Docker
function dc-fn {
  docker compose $*
}

function dcr-fn {
  docker compose run $@
}

function dex-fn {
  docker exec -it $1 ${2:-bash}
}
