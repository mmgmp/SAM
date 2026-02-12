#!/bin/bash

#===== INSTALACIÓN =====#

echo -e "\nElige el entorno de escritorio (separar varios con espacios):"
echo -e " 1) Sway\n 2) Niri\n"
read -p "Selección/es (Enter para saltar): " desktop_choices

for choice in $desktop_choices; do
	case $choice in
		1) bash ./ress/wm/sway.sh || exit 1 ;;
        2) bash ./res/wm/niri.sh && bash ./res/standalone/xwayland-satellite.sh || exit 1 ;;
    esac
done

# Paquetes de los repositorios oficiales
pkgs_list="res/pkgs"
sudo apt install -y $(grep -vE '^\s*#' "$pkgs_list" | grep -vE '^\s*$' | sed 's/#.*//' | awk '{$1=$1};1' | tr '\n' ' ') || exit 1

# Navegador web
echo -e "\nElige el navegador web (separar varios con espacios):"
echo -e " 1) Brave\n 2) Firefox-esr\n"
read -p "Selección/es (Enter para saltar): " browser_choices

for choice in $browser_choices; do
	case $choice in
		1) curl -fsS https://dl.brave.com/install.sh | sh ;;
        2) sudo apt install -y firefox-esr ;;
    esac
done

# Flatpak
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Aplicaciones GTk4 oscuras
dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'

# Crear carpetas para fuentes
[ -d ~/.local/share/fonts ] || mkdir -p ~/.local/share/fonts

# Descargar FiraMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/FiraMono.zip
7z x FiraMono.zip -oFiraMono
cp FiraMono/Fira*.otf ~/.local/share/fonts

# Actualizar cache de fuentes
fc-cache -f

# Instalar Ly (display manager)
bash ./res/standalone/ly.sh

# Descargar yt-dlp de github
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
chmod +x yt-dlp
sudo mv -f yt-dlp /usr/bin/yt-dlp

# Instalar Starship prompt
curl -sS https://starship.rs/install.sh | sh
sudo mv /usr/local/bin/starship /usr/bin/
starship preset plain-text-symbols -o ~/.config/starship.toml

# Preguntar si quieres instalar auto-cpufreq
read -p "¿Quieres instalar auto-cpufreq? (s/N): " auto_cpufreq
if [ "$auto_cpufreq" = "s" ] || [ "$auto_cpufreq" = "S" ]; then
    bash ./res/auto-cpufreq.sh
else
    echo "No se instalará auto-cpufreq."
fi

#===== CONFIGURACIÓN =====#

# Ocultar el manú GRUB
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub

# Mostrar rueda giratoria
sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
sudo plymouth-set-default-theme -R spinner

# Actualizar GRUB
sudo update-grub

# Desactivar archivo .sudo_as_admin_successful
echo 'Defaults !admin_flag' | sudo tee /etc/sudoers.d/no_admin_flag
rm ~/.sudo_as_admin_successful

# Historial de bash en XDG
mkdir -p ~/.local/state/bash && touch ~/.local/state/bash/history
source ~/.bashrc && rm ~/.bash_history

# Configuracion de git en XDG
mkdir -p ~/.config/git && touch ~/.config/git/config && rm ~/.gitconfig

# Crear carpetas del usuario
xdg-user-dirs-update

# Colocar mis dotfiles
git clone https://github.com/mmgmp/dotfiles
cp -r dotfiles/{.bashrc,.profile,.config,.local} ~/

echo -e "\nCompletado, puedes reiniciar el ordenador con el comando 'systemctl reboot'\n"
