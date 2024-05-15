#!/bin/bash

# Instalar sway y complementos
sudo apt install -y sway swayidle swaybg swaylock waybar xwayland

# Iniciar sway en la tty
touch .profile
printf "\n# Autoejecutar sway el la tty\nif [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then\n    exec sway\nfi" >> .profile

# Sway autotiling
sudo apt install -y python3-i3ipc
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py autotiling
chmod +x autotiling
sudo mv autotiling /usr/bin/autotiling

# Menu de arranque
sudo apt install -y tofi

# Navegador
sudo apt install -y firefox-esr

# Gestor de archivos
sudo apt install -y lf

# Multimedia
sudo apt install -y mpv brightnessctl swayimg

# Notificaciones
sudo apt install -y sway-notification-center libnotify-bin

# Programas adicionales
sudo apt install -y unzip curl network-manager newsboat pass pass-otp pinentry-gnome3 neovim abook htop

# Instalar PipeWire
sudo apt install -y pipewire pulseaudio-utils pavucontrol
systemctl --user --now enable wireplumber.service

# Instalar flatpak y añadir flathub.com
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Descargar Font Awesome 5
mkdir -p ~/.local/share/fonts
wget https://use.fontawesome.com/releases/v5.15.4/fontawesome-free-5.15.4-desktop.zip
unzip fontawesome-free-5.15.4-desktop.zip
cp fontawesome-free-5.15.4-desktop/otfs/*.otf ~/.local/share/fonts

# Descargar FiraMono Nerd Font
mkdir FiraMonoNerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
unzip FiraMono.zip -d FiraMonoNerdFont
cp FiraMonoNerdFont/Fira*.otf ~/.local/share/fonts

# Descargar UbuntuMono Nerd Font
mkdir UbuntuMonoNerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/UbuntuMono.zip
unzip UbuntuMono.zip -d UbuntuMonoNerdFont
cp UbuntuMonoNerdFont/Ubuntu*.ttf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f -v

# Descargar fondo de escritorio
mkdir -p ~/.local/share/backgrounds
wget https://raw.githubusercontent.com/mmgmp/fondos-de-pantalla/main/pixel-paisaje.png
mv pixel-paisaje.png ~/.local/share/backgrounds/pixel-paisaje.png

# Colocar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp dotfiles/.bashrc ~/.bashrc
cp -r dotfiles/.config ~/
cp -r dotfiles/.local ~/

# Carpeatas XDG
xdg-user-dirs-update
mkdir -p ~/.local/state/bash
mkdir -p ~/.local/share/gnupg

# Limpiar restos
cd ~/
rm -r --interactive=never sam/
