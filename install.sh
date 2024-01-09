#!/bin/bash

# install homebrew
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install chezmoi
brew install chezmoi

# apply chezmoi dotfiles repo
chezmoi init --apply git@github.com:jacob-shuman/dotfiles-test.git

brew bundle install
