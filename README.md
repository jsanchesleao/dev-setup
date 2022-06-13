# dev-setup
tools and configs for coding

# What needs to be installed

- [ohmyz.sh](https://ohmyz.sh/)
- [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [fzf](https://github.com/junegunn/fzf)
- [neovim](https://neovim.io/)
- [tmux](https://github.com/tmux/tmux/wiki)

# Configurations

## OhMyZsh

Copy the `bin`  folder to your home directory, and copy `.zshrc` also to the home directory.
Then run `p10k configure`

## Tmux

Copy `tmux.conf` to the home directory

Inside the `bin/find-to-tmux` file, edit the `PROJECTS_DIR` variable with the correct path

## NeoVim

First install [Plug](https://github.com/junegunn/vim-plug)

Copy the entire `config/nvim` folder to `~/.config/nvim`

Then open nvim and run `:PlugInstall`

