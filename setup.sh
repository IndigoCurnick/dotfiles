#!/usr/bin/bash

optional_development() {
    # VScode
    sudo pacman -S code --noconfirm 
    yay -S code-marketplace --noconfirm 

    cat dotfiles/vscode/extensions.list | lines | each {|e| code --install-extension $e }

    # Make/cmake/gcc

    sudo pacman -S make cmake gcc --noconfirm 

    # Python

    sudo pacman -S python --noconfirm 
    yay -S rye-bin --noconfirm 

    # LaTeX 
    # sudo pacman -S texlive-most texlive-lang --noconfirm 

}

optional_office() {
    # Libre office
    sudo pacman -S libreoffice-fresh hunspell-en_gb --noconfirm 

    # eBooks
    sudo pacman -S calibre foliate --noconfirm 

    # Image manipulation 
    sudo pacman -S gimp --noconfirm 

    # Markdown editing
    sudo pacman -S ghostwriter obsidian --noconfirm 
}

optional_social() {
    sudo pacman -S discord telegram-desktop --noconfirm 
}

install_yay() {
    sudo pacman -S yay --noconfirm 
}

wm() {
    # Setting up basic desktop env
    sudo pacman -S xorg xorg-xinit firefox awesome lightdm vim alacritty dmenu --noconfirm 

    sudo cp /etc/X11/xinit/xinitrc .xinitrc

    sudo sh -c 'echo "exec awesome\n" >> ".xinitrc"'

    sudo pacman -S lightdm-gtk-greeter --noconfirm 

    sudo sh -c 'echo "greeter-session=lightdm-gtk-greeter\n" >> "/etc/lightdm/lightdm.conf"'

    sudo systemctl enable lightdm -f

    # Compositor

    sudo pacman -S picom --noconfirm 

    # alacritty config 
    mkdir ~/.config/alacritty
    cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

    # Wallpaper 

    sudo pacman -S feh --noconfirm 

    mkdir ~/Pictures
    mkdir ~/Pictures/wallpapers
    cp dotfiles/wallpaper/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

    # Awesome Theme
    cp -r dotfiles/awesome ~/.config
}

audio() {
    sudo pacman -S volumeicon --noconfirm 

    cd ~/.config/awesome
    git clone https://github.com/davlord/awesome-pulseaudio-widget.git
    cd ~

    sudo pacman -S pulseaudio pulseaudio-equalizer-ladspa --noconfirm 

    sudo pacman -S clementine --noconfirm 
    cp dotfiles/Clementine/Clementine.conf ~/.config/Clementine/Clementine.conf
}

utils() {
    sudo pacman -S zsh gnome-disk-utility lf dolphin ark vim --noconfirm 

    # Screenshots

    sudo pacman -S spectacle --noconfirm 

    # Video player

    sudo pacman -S vlc --noconfirm 

    # pdf viewer
    sudo pacman -S evince --noconfirm 

    # Bat
    sudo pacman -S bat --noconfirm 
}

make_dirs() {
    mkdir ~/Documents
    mkdir ~/Downloads
    # mkdir ~/Pictures
    # Maybe I could do pictures here instead?
    mkdir ~/Videos
}

welcome() {
    cat welcome.txt

    echo "Welcome to Crucible!"
    echo "This script will guide you through installing Crucible"
    echo "It is mostly hands off, with some configuration"
    echo "You may be required to enter the root password"
}

outro() {
    echo "Congratulations! You are now using Crucible!"
    echo "If there were no hidden errors, you can now reboot and enjoy your new system (✿◠‿◠)"
    echo "Please let me know what you thought of the script and system at https://github.com/IndigoCurnick/dotfiles"
    echo "Alternatively, email me at indigocurnick@gmail.com"
}

core() {
    echo "Do you want optional development packages? y/n"
    # read in_dev

    # if [ $in_dev = 'y' ]; then
    #     dev=true
    # elif [ $in_dev = 'n' ]; then
    #     dev=false
    # else 
    #     echo "Unknown option"
    #     exit 1
    # fi

    echo "Do you want optional office packages? y/n"
    # read in_off

    # if [ $in_off = 'y' ]; then
    #     off=true
    # elif [ $in_off = 'n' ]; then
    #     off=false
    # else 
    #     echo "Unknown option"
    #     exit 1
    # fi

    echo "Do you want optional social packages? y/n"
    # read in_soc

    # if [ $in_soc = 'y' ]; then
    #     soc=true
    # elif [ $in_soc = 'y' ]; then
    #     soc=false
    # else 
    #     echo "Unknown option"
    #     exit 1
    # fi

    # install_yay
    mkdir ~/.config
    wm 
    utils
    audio
    make_dirs

    # if [ $dev = true ]; then 
    #     optional_development
    # fi 

    # if [ $off = true ]; then
    #     optional_office
    # fi

    # if [ $soc = true ]; then
    #     optional_social
    # fi
}


welcome
core
outro