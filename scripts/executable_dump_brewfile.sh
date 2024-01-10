#!/bin/bash

brew bundle dump --global --force ~/.Brewfile
chezmoi add ~/.Brewfile
