#!/bin/bash

# Instalar sway y complementos
sudo apt install -y sway swayidle swaybg swaylock waybar xwayland tofi

# Sway autotiling
sudo apt install -y python3-i3ipc
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py autotiling
chmod +x autotiling
sudo mv autotiling /usr/bin/autotiling

# Navegador
sudo apt install -y firefox-esr

# Gestor de archivos
sudo apt install -y lf

# Multimedia
sudo apt install -y mpv brightnessctl swayimg

# Notificaciones
sudo apt install -y mako-notifier libnotify-bin

# Captura de pantalla
sudo apt install -y grim slurp

# Programas adicionales
sudo apt install -y unzip zip unrar-free 7zip curl network-manager newsboat pass pass-otp pinentry-gnome3 neovim abook htop neofetch bash-completion udisks2 gammastep gh zathura zathura-pdf-poppler

# Instalar PipeWire y activar audio
sudo apt install -y pipewire pulseaudio-utils pavucontrol
systemctl --user --now enable wireplumber.service

# Instalar flatpak y añadir flathub.com
sudo apt install -y flatpak
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Crear carpetas para fuentes
mkdir -p ~/.local/share/fonts

# Descargar Font Awesome 5
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
unzip fontawesome-free-5.15.4-desktop.zip
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts

# Descargar FiraMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
unzip FiraMono.zip -d FiraMono
cp FiraMono/Fira*.otf ~/.local/share/fonts

# Descargar UbuntuMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
unzip UbuntuMono.zip -d UbuntuMono
cp UbuntuMono/Ubuntu*.ttf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f -v

# Montar USBs en /media
mkdir -p /etc/udev/rules.d
touch 99-udisks2.rules
printf 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' > 99-udisks2.rules
sudo mv 99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules

# Instalar Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Colocar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp dotfiles/.bashrc ~/.bashrc
cp dotfiles/.profile ~/.profile
cp -r dotfiles/.config ~/
cp -r dotfiles/.local ~/

# Configurar pinentry-gnome3
mkdir -p ~/.local/share
touch ~/.local/share/gpg-agent.conf
printf 'pinentry-program /usr/bin/pinentry-gnome3' > ~/.local/share/gpg-agent.conf

# Descargar yt-dlp actual
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
mv yt-dlp ~/.local/bin/yt-dlp

# Hacer scripts ejecutables
chmod +x ~/.config/waybar/modules/*
chmod +x ~/.local/bin/*

# Carpetas XDG
xdg-user-dirs-update
mkdir -p ~/.local/state/bash
touch ~/.local/state/bash/history

# Desactivar archivo .sudo_as_admin_successful
sudo touch /etc/sudoers.d/no_admin_flag
sudo printf 'Defaults !admin_flag' > /etc/sudoers.d/no_admin_flag

# Limpiar restos
cd ~/
rm -r --interactive=never SAM/

printf "\nCompletado, puedes reiniciar el ordenador con el comando 'systemctl reboot'\n"
