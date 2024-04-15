#!/bin/bash

# Instalar y activar ly
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly/
make
sudo make install installsystemd
sudo systemctl enable ly.service
cd ..
rm -r --interactive=never ly

# Instalar sway y complementos
sudo apt install -y sway swayidle swaylock waybar tofi

# Instalar programas adicionales
sudo apt install -y firefox-esr lf unzip network-manager brightnessctl mpv newsboat pass pass-otp neovim abook

# Instalar pipewire y wireplumber (audio)
sudo apt install -y wireplumber pipewire-pulse pulseaudio-utils 
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service

# Instalar flatpak y añadir flathub.com
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Descargar e instalar font awesome
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
mkdir -p ~/.local/share/fonts
unzip fontawesome-free-5.15.4-desktop.zip
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts
rm -r --interactive=never fontawesome-free-*
fc-cache -f -v

# Descargar fondo de escritorio
wget https://github.com/mmgmp/fondos-de-pantalla/blob/main/pixel-paisaje.png
mkdir -p ~/Imágenes/Fondos
cp pixel-paisaje.png ~/Imágenes/Fondos/pixel-paisaje.png

# Descargar scripts de tofi
git clone https://github.com/mmgmp/tofi-scripts
mkdir -p ~/.local/share/bin
cp -r /tofi-scripts/*.sh ~/.local/share/bin/
rm -r --interactive=never tofi-scripts/

# Crear carpetas del usuario
xdg-user-dirs-update
cd ~/Descargas/

# Descargar dotfiles de github
git clone https://github.com/mmgmp/dotfiles

# Colocar archivos config
mkdir -p ~/.local/state/bash
mkdir -p ~/.local/share/gnupg

cp -r dotfiles/.config/sway ~/.config/
cp -r dotfiles/.config/waybar ~/.config/
cp -r dotfiles/.config/tofi ~/.config/
cp -r dotfiles/.config/newsboat ~/.config/
cp -r dotfiles/.config/nvim ~/.config/
cp -r dotfiles/.config/lf ~/.config/
cp dotfiles/.bashrc ~/.bashrc

