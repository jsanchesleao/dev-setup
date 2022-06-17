#!/usr/bin/env bash

echo "Restoring tmux config"
cp ./configs/.tmux.conf ~/.tmux.conf

echo "Restoring zsh config"
cp ./configs/.zshrc ~/.zshrc 

echo "Restoring nvim config"
cp -r ./configs/nvim ~/.configs

echo "Restoring custom commands"
cp -r ./bin ~

echo -e "\nDone"

