#!/usr/bin/env nu

def optional_development [] {
    # VSCode
    sudo pacman -S code 
    yay -S code-marketplace

    cat dotfiles/vscode/extensions.list | lines | each {|e| code --install-extension $e }

    # make/cmake

    sudo pacman -S make cmake

    # Rust
    sudo pacman -S rustup

    # Go
    sudo pacman -S go

    # Python 
    sudo pacman -S python pipenv

    # LaTeX 
    sudo pacman -S texlive-most texlive-lang
}

def optional_office [] {
    # Libre office
    sudo pacman -S libreoffice-fresh hunspell-en_gb

    # eBooks
    sudo pacman -S calibre foliate

    # Image manipulation 
    sudo pacman -S gimp

    # Markdown editing
    sudo pacman -S ghostwriter zettlr
}

def optional_social [] {
    sudo pacman -S discord telegram-desktop 
}

def install_yay [keep: bool] {
    # First basic setup
    sudo pacman -S base-devel git go 

    # Building and installing yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si

    if not $keep {
        sudo pacman -Rns go
    }
}

def wm [] {
    # Setting up basic desktop env
    cd ..
    sudo pacman -S xorg xorg-xinit firefox awesome lightdm vim alacritty dmenu

    sudo cp /etc/X11/xinit/xinitrc .xinitrc

    sudo -E nu -c 'echo "exec awesome\n" | save -a .xinitrc'

    sudo pacman -S lightdm-gtk-greeter

    sudo -E nu -c 'echo "greeter-session=lightdm-gtk-greeter\n" | save -a /etc/lightdm/lightdm.conf'

    sudo systemctl enable lightdm -f

    # Compositor

    sudo pacman -S picom

    # alacritty config 
    mkdir ~/.config/alacritty
    cp dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

    # Wallpaper 

    sudo pacman -S feh

    mkdir ~/Pictures
    mkdir ~/Pictures/wallpapers
    cp dotfiles/wallpaper/wallpaper.png ~/Pictures/wallpapers/wallpaper.png

    # Awesome Theme
    cp dotfiles/awesome ~/.config
}

def audio [] {
    sudo pacman -S volumeicon 

    cd ~/.config/awesome
    git clone https://github.com/davlord/awesome-pulseaudio-widget.git

    cd ~

    sudo pacman -S pulseaudio pulseaudio-equalizer-ladspa

    sudo pacman -S clementine
    cp dotfiles/Clementine/Clementine.conf ~/.config/Clementine/Clementine.conf
}

def utils [] {
    sudo pacman -S gnome-disk-utility

    sudo pacman -S lf thunar

    sudo pacman -S ark

    # Screenshots

    sudo pacman -S spectacle

    # Video player

    sudo pacman -S vlc

    # pdf viewer
    sudo pacman -S evince

    # Bat
    sudo pacman -S bat
}

def make_dirs [] {
    mkdir ~/Documents
    mkdir ~/Downloads
    # mkdir ~/Pictures
    # Maybe I could do pictures here instead?
    mkdir ~/Videos
}

def core [] {
    print "Do you want optional development packages? y/n"
    mut dev = (input)

    if $dev == "y" { $dev = true } else if $dev == "n" { $dev = false } else { 
        print "Unknown option"
        exit
    }

    print "Do you want optional office packages? y/n"
    mut off = (input)

    if $off == "y" { $off = true } else if $off == "n" { $off = false } else { 
        print "Unknown option"
        exit
    }

    print "Do you want optional social packages? y/n"
    mut soc = (input)

    if $soc == "y" { $soc = true } else if $soc == "n" { $soc = false } else { 
        print "Unknown option"
        exit
    }

    install_yay $dev
    wm 
    utils
    make_dirs

    if $dev { optional_development }
    if $off { optional_office }
    if $soc { optional_social }
}

def welcome [] {
    let welcome_text = (cat welcome.txt)
    print $welcome_text 

    print "Welcome to Crucible"
    print "This script will guide you through installing Crucible"
    print "It is mostly hands off, with some configuration"
    print "You may be required to enter the root password"
}

def outro [] {
    print "Congratulations! You are now using Crucible!"
    print "If there were no hidden errors, you can now reboot and enjoy your new system (✿◠‿◠)"
}

welcome
core
outro




