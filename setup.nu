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

echo "exec awesome\n" | save -a .xinitrc

sudo pacman -S lightdm-gtk-greeter -y

sudo -E nu -c 'echo "greeter-session=lightdm-gtk-greeter\n" | save -a /etc/lightdm/lightdm.conf'

sudo systemctl enable lightdm -f

# Compositor

sudo pacman -S picom

echo "picom &\n" | save -a .xinitrc

# alacritty config 
mkdir -p ~/.config/alacritty && cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# Wallpaper 

sudo pacman -S feh

mkdir ~/Pictures
mkdir ~/Pictures/wallpapers

cp dotfiles/wallpaper/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

mkdir ~/.config/awesome

echo "awful.spawn.with_shell("feh --bg-fill ~/Pictures/wallpapers/wallpaper.png")" | save -a ~/.config/awesome/rc.lua