#!/bin/bash

#= FUNCIÓNES =================================================================================#

main_setup() {
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

	# Programas adicionales
	sudo apt install -y unzip zip curl network-manager newsboat pass pass-otp pinentry-gnome3 neovim abook htop neofetch bash-completion udisks2 gammastep
}

audio_setup() {
	# Instalar PipeWire
	sudo apt install -y pipewire pulseaudio-utils pavucontrol
	systemctl --user --now enable wireplumber.service
}

flatpak_setup() {
	# Instalar flatpak y añadir flathub.com
	sudo apt install -y flatpak
	flatpak remote-add --user --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

fonts_setup() {
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
}

custom_setup() {
	# Montar USBs en /media
	mkdir -p /etc/udev/rules.d
	touch 99-udisks2.rules
	printf 'ENV{ID_FS_USAGE}=="filesystem|other|crypto", ENV{UDISKS_FILESYSTEM_SHARED}="1"' > 99-udisks2.rules
	sudo mv 99-udisks2.rules /etc/udev/rules.d/99-udisks2.rules

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
}

#= SCRIPT ====================================================================================#

main_setup >/dev/null 2>&1
audio_setup >/dev/null 2>&1
flatpak_setup >/dev/null 2>&1
fonts_setup >/dev/null 2>&1
custom_setup >/dev/null 2>&1

printf "¿Quieres instalar el perfil para gaming? [s/N]" ; read ans
[ $ans = "s" ] && printf "Instalando el perfil gaming..." ; bash ~/SAM/profiles/gaming >/dev/null 2>&1 ; printf "Instalado" || printf "No se instalará el perfil gaming"

# Limpiar restos
cd ~/
rm -r --interactive=never SAM/
