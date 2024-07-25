#!/bin/bash

#===== INSTALACIÓN =====#

# Instalar sway y complementos
sudo apt install -y sway swayidle swaybg swaylock waybar xwayland tofi

# Sway autotiling
sudo apt install -y python3-i3ipc
wget https://raw.githubusercontent.com/nwg-piotr/autotiling/master/autotiling/main.py
mv main.py autotiling && chmod +x autotiling
sudo mv autotiling /usr/bin/autotiling

# Instalar Ly (display manager)
source /recursos/ly

# Navegador web
sudo apt install -y firefox-esr

# Gestor de archivos
sudo apt install -y lf

# Multimedia
sudo apt install -y mpv brightnessctl swayimg zathura zathura-pdf-poppler gammastep

# Notificaciones
sudo apt install -y mako-notifier libnotify-bin

# Captura de pantalla
sudo apt install -y grim slurp

# Programas adicionales
sudo apt install -y unzip zip unrar-free 7zip curl network-manager newsboat pass pass-otp neovim abook htop bash-completion udisks2 gh wob nala fonts-firacode

# Instalar PipeWire y activar audio
sudo apt install -y pipewire pulseaudio-utils pavucontrol
systemctl --user --now enable wireplumber.service

# Instalar flatpak y añadir flathub.com
sudo apt install -y flatpak
flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Crear carpetas para fuentes
mkdir -p ~/.local/share/fonts

# Descargar FiraMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
unzip FiraMono.zip -d FiraMono
cp FiraMono/Fira*.otf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f -v

# Instalar nwg-look (lxappearance para wayland)
source /resursos/nwg-look

# Instalar Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Descargar yt-dlp de github
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
sudo mv -f yt-dlp /usr/bin/yt-dlp

#===== CONFIGURACIÓN =====#

# Colocar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp -r dotfiles/{.bashrc,.profile,.config,.local} ~/

# Colocar historial de bash en .local/state/bash
mkdir -p ~/.local/state/bash
touch ~/.local/state/bash/history
source ~/.bashrc && rm ~/.bash_history

# Montar USB en /media
mkdir -p /etc/udev/rules.d
echo 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' | sudo tee /etc/udev/rules.d/99-udisks2.rules

# Desactivar archivo .sudo_as_admin_successful
echo 'Defaults !admin_flag' | sudo tee /etc/sudoers.d/no_admin_flag

# Instalar y configurar pinentry-gnome3
sudo apt install -y pinentry-gnome3
mkdir -p ~/.local/share
printf 'pinentry-program /usr/bin/pinentry-gnome3' > ~/.local/share/gpg-agent.conf

# Crear carpetas del usuario
xdg-user-dirs-update

# Limpiar restos
cd ~/
sudo rm -r --interactive=never SAM/

printf "\nCompletado, puedes reiniciar el ordenador con el comando 'systemctl reboot'\n"
