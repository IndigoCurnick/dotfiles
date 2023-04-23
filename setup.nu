#!/usr/bin/env nu

# First basic setup
sudo pacman -S base-devel git go -y

# Building and installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Setting up basic desktop env
cd ..
sudo pacman -S xorg xorg-xinit firefox awesome lightdm vim alacritty -y

cp /etc/X11/xinit/xinitrc .xinitrc

echo "exec awesome" | save -a .xinitrc

sudo pacman -S lightdm-gtk-greeter -y

sudo -E nu -c 'echo "greeter-session=lightdm-gtk-greeter" | save -a /etc/lightdm/lightdm.conf'

sudo systemctl enable lightdm -f

# Compositor

sudo pacman -S picom

echo "picom &" | save -a .xinitrc

# alacritty config 
cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml