#!/usr/bin/env nu

# First basic setup
sudo pacman -S base-devel git go -y

# Building and installing yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Setting up basic desktop env
cd ..
sudo pacman -S xorg xorg-xinit firefox awesome lightdm vim alacritty dmenu

cp /etc/X11/xinit/xinitrc .xinitrc

echo "exec awesome\n" | save -a .xinitrc

sudo pacman -S lightdm-gtk-greeter -y

sudo -E nu -c 'echo "greeter-session=lightdm-gtk-greeter\n" | save -a /etc/lightdm/lightdm.conf'

sudo systemctl enable lightdm -f

# Compositor

sudo pacman -S picom

# echo "picom &\n" | save -a .xinitrc

echo "awful.spawn.with_shell('picom')\n" | save -a ~/.config/awesome/rc.lua

# alacritty config 
mkdir -p ~/.config/alacritty && cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

# Wallpaper 

cp /etc/xdg/awesome/rc.lua ~/.config/awesome

sudo pacman -S feh

mkdir ~/Pictures
mkdir ~/Pictures/wallpapers

cp dotfiles/wallpaper/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

mkdir ~/.config/awesome

echo "awful.spawn.with_shell('feh --bg-fill ~/Pictures/wallpapers/wallpaper.png')\n" | save -a ~/.config/awesome/rc.lua

# Fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra

# Terminal default
sed -i '/terminal = "xterm"/d' ~/.config/awesome/rc.lua

line_number=$(grep -n 'terminal = "xterm"' ~/.config/awesome/rc.lua | cut -d: -f1)
sed -i '${line_number}s/.*/terminal = "alacritty"/' ~/.config/awesome/rc.lua

# Audio

sudo pacman -S volumeicon 

# Theming awesome