#!/bin/bash
# Script para instalar o token G&D no Ubuntu 24.04 LTS e Linux Mint 22.x

# Instala dependências
echo "Instalando dependências..."
sudo apt install -y libpcsclite1 libccid pcscd libjbig0 fontconfig-config libfontconfig1

# Verifica se o arquivo SafeSign existe
SAFESIGN_DEB="/home/$USER/Stage/token-gd-ubuntu-mint/drivers/SafeSign_Linux_4.2.1-AET_000_ub2404_x86_64.deb"
if [ ! -f "$SAFESIGN_DEB" ]; then
    echo "Erro: Arquivo $SAFESIGN_DEB não encontrado em ~/Stage/token-gd-ubuntu-mint/drivers"
    exit 1
fi

# Instala o pacote .deb
echo "Instalando o SafeSign..."
SAFESIGN_PKG="/home/$USER/Stage/token-gd-ubuntu-mint/drivers/SafeSign_Linux_4.2.1-AET_000_ub2404_x86_64.deb"
sudo dpkg -i "$SAFESIGN_PKG"
sudo apt install -f -y

# Instala pacotes legados
echo "Instalando pacotes legados..."

cd /tmp
wget -q http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb
sudo dpkg -i libssl1.1_1.1.1-1ubuntu2.1~18.04.23_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/main/g/gdk-pixbuf-xlib/libgdk-pixbuf-xlib-2.0-0_2.40.2-2build4_amd64.deb
sudo dpkg -i libgdk-pixbuf-xlib-2.0-0_2.40.2-2build4_amd64.deb
wget -q http://archive.ubuntu.com/ubuntu/pool/universe/g/gdk-pixbuf-xlib/libgdk-pixbuf2.0-0_2.40.2-2build4_amd64.deb
sudo dpkg -i libgdk-pixbuf2.0-0_2.40.2-2build4_amd64.deb
sudo apt install -f -y

# Verifica o serviço pcscd
echo "Configurando o serviço pcscd..."
sudo systemctl enable pcscd.socket
sudo systemctl start pcscd

echo "Instalação concluída! Siga as instruções no README.md para configurar o Firefox."
