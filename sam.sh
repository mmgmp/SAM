#!/bin/bash

installpkg() {
	sudo apt install -y "$@" >/dev/null 2>&1
}

# Instalar sway y complementos
installpkg sway swayidle swaybg swaylock waybar xwayland

# Sway autotiling
installpkg python3-i3ipc
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py autotiling
chmod +x autotiling
sudo mv autotiling /usr/bin/autotiling

# Menu de arranque
installpkg tofi

# Navegador
installpkg firefox-esr

# Gestor de archivos
installpkg lf

# Multimedia
installpkg mpv brightnessctl swayimg

# Notificaciones
installpkg mako-notifier libnotify-bin

# Programas adicionales
installpkg unzip zip curl network-manager newsboat pass pass-otp pinentry-gnome3 neovim abook htop bash-completion udisks2 gammastep

# Instalar PipeWire
installpkg pipewire pulseaudio-utils pavucontrol
systemctl --user --now enable wireplumber.service

# Montar USBs en /media
mkdir -p /etc/udev/rules.d
touch 99-udisks2.rules
printf 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' > 99-udisks2.rules
sudo mv 99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules

# Instalar flatpak y añadir flathub.com
installpkg flatpak
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

# Descargar fondo de escritorio
mkdir -p ~/.local/share/backgrounds
wget https://raw.githubusercontent.com/mmgmp/fondos-de-pantalla/main/pixel-paisaje.png
mv pixel-paisaje.png ~/.local/share/backgrounds/pixel-paisaje.png

# Colocar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp dotfiles/.bashrc ~/.bashrc
cp dotfiles/.profile ~/.profile
cp -r dotfiles/.config ~/
cp -r dotfiles/.local ~/

# Hacer scripts ejecutables
chmod +x ~/.config/waybar/modules/*
chmod +x ~/.local/bin/*

# Carpeatas XDG
xdg-user-dirs-update
mkdir -p ~/.local/state/bash
touch ~/.local/state/bash/history

# Limpiar restos
cd ~/
rm -r --interactive=never SAM/
