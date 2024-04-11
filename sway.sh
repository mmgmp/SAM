#!/bin/bash
cd ..

# Instalar Sway para Debian 12
sudo apt install -y sway

# Instalar programas adicionales
sudo apt install -y waybar tofi firefox-esr lf unzip

# Descargar dotfiles de github
git clone https://github.com/mmgmp/dotfiles

# Colocar archivos config
mkdir -p ~/.config/sway
cp dotfiles/.config/sway/config ~/.config/sway/config
https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
# Activar audio
sudo apt install -y wireplumber pipewire-pulse
systemctl --user --now enable pipewire pipewire-pulse
systemctl --user --now enable wireplumber.service

# Descargar e instalar font awesome
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
unzip fontawesome-free-5.15.4-desktop.zip
rm fontawesome-free-5.15.4-desktop.zip
mkdir -p ~/.local/share/fonts
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts
rm fontawesome-free-5.15.4-desktop
fc-cache -f -v
