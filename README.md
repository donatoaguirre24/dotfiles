# Installation steps

1. Installs Apple's Command Line Tools, which are prerequisites for Git and Homebrew

    ```sh
    xcode-select --install
    ```

2. Install Chezmoi

    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io/lb)"
    ```

3. Initialize Chezmoi using the dotfiles repository

    ```sh
    $HOME/.local/bin/chezmoi init https://github.com/donatoaguirre24/dotfiles.git
    ```

4. Create dotfiles and run scripts

    ```sh
    $HOME/.local/bin/chezmoi apply -v
    ```

5. Install the software listed in the Brewfile

    ```sh
    brew bundle check --file=$(chezmoi source-path)/Brewfile
    brew bundle --file=$(chezmoi source-path)/Brewfile
    ```

6. Install Mise tools

    ```sh
    mise install
    ```
