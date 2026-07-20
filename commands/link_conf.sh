#!/bin/sh

DOTFILES="$HOME/dotfiles"

# --- user-space configs (no sudo needed, home dir is user-owned) ---
ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES/.xprofile" "$HOME/.xprofile"
ln -sf "$DOTFILES/.xinitrc" "$HOME/.xinitrc"
ln -sf "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config/i3"
ln -sf "$DOTFILES/i3.config" "$HOME/.config/i3/config"

mkdir -p "$HOME/.config/kitty"
ln -sf "$DOTFILES/kitty.conf" "$HOME/.config/kitty/kitty.conf"

mkdir -p "$HOME/.config/picom"
ln -sf "$DOTFILES/picom.conf" "$HOME/.config/picom.conf"

mkdir -p "$HOME/.config/polybar"
ln -sf "$DOTFILES/polybar.conf" "$HOME/.config/polybar/config"

mkdir -p "$HOME/.config/dunst"
ln -sf "$DOTFILES/dunstrc" "$HOME/.config/dunst/dunstrc"

ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"

mkdir -p "$HOME/.config/Code/User"
ln -sf "$DOTFILES/vskeybindings.json" "$HOME/.config/Code/User/keybindings.json"

mkdir -p "$HOME/.config/systemd/user"
ln -sf "$DOTFILES/systemd/wallpaper.service" "$HOME/.config/systemd/user/wallpaper.service"
ln -sf "$DOTFILES/systemd/wallpaper.timer" "$HOME/.config/systemd/user/wallpaper.timer"
systemctl --user daemon-reload
systemctl --user enable --now wallpaper.timer

# --- system paths (need root) ---
sudo ln -sf "$DOTFILES/custom" /usr/share/X11/xkb/symbols/custom
sudo ln -sf "$DOTFILES/custom_ru" /usr/share/X11/xkb/symbols/custom_ru

# apply immediately if already inside an X session (no-op/harmless if not)
setxkbmap -layout es,custom_ru -option grp:win_space_toggle 2>/dev/null

sudo mkdir -p /etc/keyd
sudo ln -sf "$DOTFILES/keyd5layer.conf" /etc/keyd/keyd.conf
sudo systemctl restart keyd
