#!/bin/sh

sudo ln -sf ~/dotfiles/.zshrc ~/.zshrc
sudo ln -sf ~/dotfiles/custom /usr/share/X11/xkb/symbols/custom
sudo ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

echo "install oh-my-zsh and dependencies?(y/n)"
read zsh_dep
echo $zsh_dep

if [ "$zsh_dep"="y" ]; then
	echo "Installing zsh and dependencies"
#	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	git clone https://github.com/zsh-users/zsh-autosuggestions \
	  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
	  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

	git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git \
	  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autocomplete
else
	echo "skiping zsh"
fi

