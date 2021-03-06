#!/usr/bin/env bash

echo "Backing up tmux config"
cp ~/.tmux.conf ./configs

echo "Backing up zsh config"
cp ~/.zshrc ./configs

echo "Backing up nvim config"
cp -r ~/.config/nvim ./configs

echo "Backing up custom commands"
cp -r ~/bin .

echo -e "\nDone"
