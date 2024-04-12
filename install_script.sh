#!/bin/bash

# Instalar y activar ly
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly/
make
sudo make install installsystemd
sudo systemctl enable ly.service
cd ..
rm -f ly

# Instalar Sway para Debian 12
sudo apt install -y sway

# Instalar programas adicionales
sudo apt install -y waybar tofi firefox-esr lf unzip network-manager wireplumber pipewire-pulse brightnessctl pulseaudio-utils nala swayidle swaylock mpv newsboat pass neovim abook

# Crear carpetas del usuario
xdg-user-dirs-update

# Activar audio
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service

# Activar flatpak y configurar flathub
sudo apt install flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

cd ~/Descargas/

# Descargar e instalar font awesome
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
unzip fontawesome-free-5.15.4-desktop.zip
rm fontawesome-free-5.15.4-desktop.zip
mkdir -p ~/.local/share/fonts
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts
rm -r fontawesome-free-5.15.4-desktop
fc-cache -f -v

# Descargar fondo de escritorio
wget https://github.com/mmgmp/fondos-de-pantalla/blob/main/pixel-paisaje.png?raw=true
mkdir -p ~/Imágenes/Fondos
mv pixel-paisaje.png?raw=true ~/Imágenes/Fondos/pixel-paisaje.png

# Descargar dotfiles de github
wget https://github.com/mmgmp/dotfiles

# Colocar archivos config
mkdir -p ~/.config/sway
mkdir -p ~/.config/waybar
mkdir -p ~/.config/tofi
mkdir -p ~/.config/newsboat
mkdir -p ~/.config/nvim
mkdir -p ~/.local/state/bash
mkdir -p ~/.local/share/gnupg

cp dotfiles/.config/sway/config ~/.config/sway/config
cp dotfiles/.config/waybar/* ~/.config/waybar/
cp dotfiles/.config/sway/tofi ~/.config/tofi/config
cp dotfiles/.config/newsboat/config ~/.config/newsboat/config
cp dotfiles/.config/nvim ~/.config/nvim

cp dotfiles/.bashrc ~/.bashrc
