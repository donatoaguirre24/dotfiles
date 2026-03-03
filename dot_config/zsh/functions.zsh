# Force rebuild ZSH completions
rebuild-completions() {
    rm "$ZDOTDIR/.zcompdump"
    compinit -d "$ZDOTDIR/.zcompdump"
    echo "Completions rebuilt!"
}

# Curate shell history
curate-history() {
    setopt LOCAL_OPTIONS ERR_RETURN PIPE_FAIL

    local opts=( -I )
    if [[ $1 == '-a' ]]; then
        opts=()
    elif [[ -n $1 ]]; then
        print >&2 'usage: smite [-a]'
        return 1
    fi

    fc -l -n $opts 1 | \
        fzf --no-sort --tac --multi | \
        while IFS='' read -r command_to_delete; do
            printf 'Removing history entry "%s"\n' $command_to_delete
            local HISTORY_IGNORE="${(b)command_to_delete}"
            fc -W
            fc -p $HISTFILE $HISTSIZE $SAVEHIST
        done
}

# Find a file by its content and optionally print it
fcat() {
    local pattern=""
    local print_on_select=false

    if [ "$#" -eq 0 ]; then
        echo "Usage: fcat <pattern> [-p | --print]" >&2
        echo "Error: You must provide a search pattern." >&2
        return 1
    fi

    # Loop through arguments to separate the pattern from the flag.
    for arg in "$@"; do
        case "$arg" in
        -p|--print)
            print_on_select=true
            ;;
        *)
            # Ensure only one pattern is provided.
            if [ -n "$pattern" ]; then
                echo "Error: Please provide only one search pattern." >&2
                return 1
            fi
            pattern="$arg"
            ;;
        esac
    done

    # Ensure a pattern was actually found.
    if [ -z "$pattern" ]; then
        echo "Error: No search pattern was provided." >&2
        return 1
    fi

    # Check for command dependencies.
    for cmd in rg fzf; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Error: Required command '$cmd' is not installed or not in your PATH." >&2
            return 1
        fi
    done

    # Get a list of files containing the pattern.
    # --hidden: Search hidden files.
    # --glob '!.git': Exclude the .git directory.
    local file_list=$(rg --files-with-matches --hidden --glob '!.git' "$pattern")

    # If rg finds no files, print a message and exit gracefully.
    if [ -z "$file_list" ]; then
        echo "No files found matching '$pattern'."
        return 0
    fi

    # Pipe the file list to fzf for interactive selection.
    # The selection is stored in the 'selected_file' variable.
    local selected_file=$(echo "$file_list" | fzf --preview 'cat {}')

    if [ -n "$selected_file" ] && [ "$print_on_select" = true ]; then
        # If a file was selected (i.e., the user pressed Enter, not Esc)
        # and the print flag is true, then 'cat' the file's content.
        cat "$selected_file"
    elif [ -n "$selected_file" ]; then
        # If a file was selected but no flag was given, print the filename.
        echo "$selected_file"
    fi
}

# Kill the process running on a specific port. Usage: `killport PORT`
killport() {
    lsof -i TCP:$1 | grep LISTEN | awk '{print $2}' | xargs kill -9
    echo "Port" $1 "found and killed."
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

# FZF
# Use fd for listing path candidates
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
    fd --hidden --type directory --exclude .git . "$1"
}

local show_file_or_dir_preview="if [ -d {} ]; then lsd -A --color=always {} | head -200; else bat --style=numbers --color=always --line-range=:500 {}; fi"

# Use custom previews when fuzzy-completing commands
_fzf_comprun() {
    local command=$1

    shift

    case "$command" in
        cd)           fzf --preview "lsd -A --color=always --icon=always {} | head -200" "$@" ;;
        export|unset) fzf --preview "eval 'echo $'{}"                                    "$@" ;;
        *)            fzf --preview "$show_file_or_dir_preview"                          "$@" ;;
    esac
}
