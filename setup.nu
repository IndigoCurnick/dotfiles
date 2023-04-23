#!/usr/bin/env nu

# First basic setup
sudo pacman -S base-devel git go

# Building and installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Setting up basic desktop env
cd ..
sudo pacman -S xorg xorg-xinit firefox awesome lightdm vim alacritty

cp /etc/X11/xinit/xinitrc .xinitrc

"exec awesome" >> .xinitrc

sudo pacman -S lightdm-gtk-greeter

"greeter-session=lightdm-gtk-greeter" >> /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm -f