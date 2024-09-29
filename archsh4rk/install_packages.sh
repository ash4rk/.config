#!/bin/bash

sudo pacman -Syu
sudo pacman -S trash-cli xarchiver zip unzip less man zsh firefox godot telegram-desktop
yay -S selectdefaultapplication 7-zip rar

# doom emacs
sudo pacman -S emacs ripgrep fd
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
# TODO: move init.el, packages.el, config.el and custom.el

# fonts
yay -S ttf-comic-mono-git otf-comicshanns-nerd

# libs
sudo pacman -S vulkan-devel glfw glm shaderc
