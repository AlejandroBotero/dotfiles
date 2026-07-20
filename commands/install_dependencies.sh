#!/bin/sh
set -e

# --- core system / X / wm ---
sudo pacman -S --needed --noconfirm \
  xorg-server xorg-xinit xorg-xhost xorg-xinput \
  i3-wm polybar dmenu dex xss-lock i3lock picom dunst \
  networkmanager network-manager-applet \
  bluez bluez-utils blueman \
  mesa vulkan-intel vulkan-radeon \
  ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
  zsh firefox kitty feh thunar tmux which nvim brightnessctl keyd \
  luarocks lua51 luajit imagemagick libnotify python-evdev sound-theme-freedesktop xdotool

sudo systemctl enable --now NetworkManager bluetooth keyd

# --- shell ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
sudo chsh -s "$(command -v zsh)" "$USER"

ZSH_CUSTOM_DIR=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

clone_if_missing() {
  # $1 = repo url, $2 = target dir, $3.. = extra git clone flags
  target="$2"
  shift 2
  if [ ! -d "$target" ]; then
    git clone "$@" "$1" "$target"
  fi
}

clone_if_missing https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM_DIR/plugins/zsh-autosuggestions"

clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$ZSH_CUSTOM_DIR/plugins/zsh-syntax-highlighting"

clone_if_missing https://github.com/marlonrichert/zsh-autocomplete.git \
  "$ZSH_CUSTOM_DIR/plugins/zsh-autocomplete" --depth 1

# --- extra apps ---
sudo pacman -S --needed --noconfirm pipewire-pulse pavucontrol zoom

# --- AUR helper + AUR apps ---
sudo pacman -S --needed --noconfirm base-devel git
if ! command -v yay >/dev/null; then
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

yay -S --noconfirm brave-bin
