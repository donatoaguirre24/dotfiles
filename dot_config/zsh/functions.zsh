# Force rebuild ZSH completions
rebuild-completions() {
  rm "$ZDOTDIR/.zcompdump"
  compinit -d "$ZDOTDIR/.zcompdump"
  echo "Completions rebuilt!"
}

# Docker
dc-fn() {
  docker compose $*
}

dcr-fn() {
  docker compose run $@
}

dex-fn() {
  docker exec -it $1 ${2:-bash}
}
