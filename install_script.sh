#!/bin/bash

# Crear carpetas del usuario
xdg-user-dirs-update
cd ~/Descargas/

# Instalar y activar ly
sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
git clone --recurse-submodules https://github.com/fairyglade/ly
cd ly/
make
sudo make install installsystemd
sudo systemctl enable ly.service
cd ..
rm -r --interactive=never ly

# Instalar Sway para Debian 12
sudo apt install -y sway

# Instalar programas adicionales
sudo apt install -y waybar tofi firefox-esr lf unzip network-manager wireplumber pipewire-pulse brightnessctl pulseaudio-utils nala swayidle swaylock mpv newsboat pass pass-otp neovim abook

# Activar audio
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service

# Activar flatpak y configurar flathub
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Descargar e instalar font awesome
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
unzip fontawesome-free-5.15.4-desktop.zip
rm -r --interactive=never fontawesome-free-5.15.4-desktop.zip
mkdir -p ~/.local/share/fonts
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts
rm -r --interactive=never fontawesome-free-5.15.4-desktop
fc-cache -f -v

# Descargar fondo de escritorio
wget https://github.com/mmgmp/fondos-de-pantalla/blob/main/pixel-paisaje.png
mkdir -p ~/Imágenes/Fondos
mv pixel-paisaje.png ~/Imágenes/Fondos/pixel-paisaje.png

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

