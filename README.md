# Installation steps

1. Installs Apple's Command Line Tools, which are prerequisites for Git and Homebrew

    ```sh
    xcode-select --install
    ```

2. Install Chezmoi, Homebrew, and bootstrap dotfiles

    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply donatoaguirre24
    ```

3. Install the software listed in ~/.Brewfile

    ```sh
    brew bundle check --global
    brew bundle --global --no-lock
    ```

4. Install Mise tools

    ```sh
    mise install
    ```
