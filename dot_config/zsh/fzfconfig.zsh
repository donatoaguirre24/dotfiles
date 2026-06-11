#!/usr/bin/env zsh

dir_preview="lsd --almost-all --tree --depth=2 --color=always --icon=always {} | head -200"
file_preview="bat --color=always --style=numbers --theme=auto:system --line-range=:500 {}"
dir_or_file_preview="if [ -d {} ]; then $dir_preview; else $file_preview; fi"

# Use custom previews when fuzzy-completing commands
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)           fzf --preview "$dir_preview"         "$@" ;;
        export|unset) fzf --preview "eval 'echo \$'{}"     "$@" ;;
        ssh)          fzf --preview 'dig {}'               "$@" ;;
        *)            fzf --preview "$dir_or_file_preview" "$@" ;;
    esac
}

# Use fd for listing path candidates
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --hidden --type directory --exclude .git . "$1"
}

export FZF_DEFAULT_COMMAND="fd --strip-cwd-prefix --follow --hidden --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type directory"

export FZF_CTRL_T_OPTS="--preview '$dir_or_file_preview'"
export FZF_ALT_C_OPTS="--preview '$dir_preview'"
