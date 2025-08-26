#!/bin/bash
set -e

echo "[+] Mise à jour des paquets..."
sudo apt update && sudo apt upgrade -y

echo "[+] Installation des paquets requis..."
sudo apt install -y wget git hashdeep p7zip-full patchelf \
xfce4 xfce4-goodies tigervnc-standalone-server x11-xserver-utils \
mesa-utils libgl1-mesa-dri python3-tk gimp mpv vlc abiword ristretto curl

clear

# Suppression d'une ancienne installation si présente
if [ -d "$HOME/boxvidra" ]; then
echo -n "Une ancienne installation de BoxVidra est détectée. Supprimer et continuer ? (O/n)"
read rep
if [[ "$rep" =~ ^[Yy]$ ]]; then
rm -rf "$HOME/boxvidra"
else
echo "Annulation."
exit 1
fi
fi

# Sélection de la version
echo "Sélectionnez une version de BoxVidra à installer :"
echo "1) Box86 (version allégée)"
echo "2) WoW64 (version plus complète)"
read -p "Votre choix (1 ou 2) : " choice
mkdir -p ~/boxvidra
cd ~/boxvidra

case "$choice" in
1)
echo "[+] Téléchargement de glibc.box86..."
wget -c https://github.com/Chrisklucik0/BOXVIDRA-EMULATOR/releases/download/Mangohub/glibc.box86.tar.xz
tar -xf glibc.box86.tar.xz
;; 2)
echo "[+] Téléchargement de glibc.wow64..."
wget -c https://github.com/Chrisklucik0/BOXVIDRA-EMULATOR/releases/download/Mangohub/glibc.wow64.tar.xz
tar -xf glibc.wow64.tar.xz
;;
*)
echo "Option non valide."
exit 1
;;
esac

# Copier les scripts dans /usr/local/bin pour appeler BoxVidra
if [ -d glibc/opt/scripts ]; then
sudo cp glibc/opt/scripts/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
fi

echo "Installation terminée. Vous pouvez lancer BoxVidra avec :"
echo "boxvidra"
