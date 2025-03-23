# AWS profile management
awsp() {
  if [ -z "$1" ]; then
    echo "Usage: awsp [open|show|list|use <profile>]"
    return 1
  fi

  if [ "$1" = "show" ]; then
    if [ -z "$AWS_PROFILE" ]; then
      echo "Profile is not set"
    else
      echo "Profile set to '$AWS_PROFILE'"
    fi
    return
  fi

  if [ "$1" = "open" ]; then
    cursor "$HOME/.aws/config"
    return
  fi

  if [ "$1" = "list" ]; then
    grep -E '^\[profile' ~/.aws/config | sed 's/^\[profile //; s/\]//'
    return
  fi

  if [ "$1" = "use" ]; then
    if [ -n "$2" ]; then
      if ! grep -q "^\[profile $2\]" ~/.aws/config; then
        echo "Profile '$2' not found"
        return 1
      fi
      export AWS_PROFILE="$2"
      echo "Profile is set to '$AWS_PROFILE'"
      aws sso login
      return
    fi
  fi
}
