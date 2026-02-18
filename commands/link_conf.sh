#!/bin/sh

sudo ln -sf ~/dotfiles/.zshrc ~/.zshrc
sudo ln -sf ~/dotfiles/.xprofile ~/.xprofile
sudo ln -sf ~/dotfiles/custom /usr/share/X11/xkb/symbols/custom
sudo ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
sudo ln -sf ~/dotfiles/i3.config ~/.config/i3/config
sudo ln -sf ~/dotfiles/kitty.config ~/.config/kitty/kitty.config
mkdir -p ~/.config/picom
sudo ln -sf ~/dotfiles/picom.conf ~/.config/picom.conf
