# Installation steps

1. Install Chezmoi and bootstrap dotfiles

    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply donatoaguirre24
    ```

2. Install the software listed in ~/.Brewfile

    ```sh
    brew bundle check --global --no-upgrade --verbose
    brew bundle --global --no-lock
    ```

3. Install Mise tools

    ```sh
    mise install
    ```
