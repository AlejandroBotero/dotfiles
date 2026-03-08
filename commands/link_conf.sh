#!/bin/sh

sudo ln -sf ~/dotfiles/.zshrc ~/.zshrc
sudo ln -sf ~/dotfiles/.xprofile ~/.xprofile
sudo ln -sf ~/dotfiles/custom /usr/share/X11/xkb/symbols/custom
sudo ln -sf ~/dotfiles/custom_ru /usr/share/X11/xkb/symbols/custom_ru
sudo ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
sudo ln -sf ~/dotfiles/i3.config ~/.config/i3/config
sudo ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
mkdir -p ~/.config/picom
sudo ln -sf ~/dotfiles/picom.conf ~/.config/picom.conf
mkdir -p ~/.config/polybar
sudo ln -sf ~/dotfiles/polybar.conf ~/.config/polybar/config
sudo ln -sf ~/dotfiles/nvim ~/.config/nvim
sudo ln -sf ~/dotfiles/keyd5layer.conf /etc/keyd/keyd.conf
