#!/bin/bash

echo "Removendo pacote SNAP Firefox"
sudo snap remove firefox
sudo apt remove firefox
sleep 1

echo "Criando diretorio para armazenar a chave de assinatura do repositorio Mozilla"
sudo install -d -m 0755 /etc/apt/keyrings
sleep 1

echo "Impor tando chave de assinatura do repositorio Mozilla"
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
sleep 1


echo " Verificar a chave de impressao se é válida"
gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc | awk '/pub/{getline; gsub(/^ +| +$/,""); if($0 == "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3") print "\nThe key fingerprint matches ("$0").\n"; else print "\nVerification failed: the fingerprint ("$0") does not match the expected one.\n"}'
sleep 1

echo "Adicionando repositório Mozilla"
echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" | sudo tee -a /etc/apt/sources.list.d/mozilla.list > /dev/null

echo "Configurando o APT para priorizar pacotes do repositório Mozilla"
echo '
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
' | sudo tee /etc/apt/preferences.d/mozilla

sleep 1

echo "Atualizando database dos repositórios do Linux e instalando o Firefox"
sudo apt update && sudo apt install firefox
sleep 1

echo "Setup de remoção pacote SAP Firefox e instalação pacote .deb Firefox concluído com sucesso!"
