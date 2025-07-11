# Instalação do Token G&D (StarSign) no Ubuntu 24.04 LTS e Linux Mint 22.x

## Descrição
Este projeto documenta o processo de instalação e configuração do token criptográfico G&D (StarSign) em sistemas Ubuntu 24.04 LTS e Linux Mint 22.x, utilizando o SafeSign Identity Client versão 4.2.1.0. O guia é voltado para usuários que precisam configurar certificados digitais A3 para acessar serviços como PJe, eSAJ ou gov.br, com suporte ao Firefox. O procedimento utiliza o arquivo local `SafeSign_Linux_4.2.1-AET_000_ub2404_x86_64.deb` e inclui um script automatizado para simplificar a instalação.

## Funcionalidades
- Instalação do SafeSign Identity Client 4.2.1.0 a partir de um arquivo `.deb` local.
- Configuração de dependências para Ubuntu 24.04 LTS e Linux Mint 22.x.
- Integração com Firefox (versão .deb, não Snap) para uso do certificado digital.
- Script automatizado para instalação e configuração.
- Solução de erros comuns, como `sun.security.pkcs11.wrapper.PKCS11Exception: CKR_DEVICE_ERROR`.

## Tecnologias Utilizadas
- **SafeSign Identity Client 4.2.1.0**: Gerenciador do token G&D.
- **Firefox (.deb)**: Navegador configurado para acessar o token.
- **Ubuntu 24.04 LTS / Linux Mint 22.x**: Sistemas operacionais suportados.
- **Bibliotecas**: `libpcsclite1`, `libccid`, `pcscd`, `libjbig0`, `fontconfig-config`, `libfontconfig1`.
- **Bash**: Script para automação da instalação.

## Pré-requisitos
- Sistema operacional Ubuntu 24.04 LTS ou Linux Mint 22.x (64 bits).
- Arquivo `SafeSign_Linux_4.2.1-AET_000_ub2404_x86_64.deb` disponível localmente (ex.: em `~/Stage/token-gd-ubuntu-mint/drivers`).
- Token G&D (StarSign) desconectado durante a instalação.
- Conexão com a internet para instalar dependências via repositório.
- Permissões administrativas (sudo).

## Como Instalar
Siga os passos abaixo para instalar e configurar o token G&D. Certifique-se de que o token está desconectado antes de iniciar.

### 1. Atualize o Sistema
Atualize os pacotes do sistema para evitar problemas de dependências:
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. Instale o Git e Clone o Repositório
1. Verifique se o Git está instalado:
   ```bash
   git --version
   ```
   Se o Git não estiver instalado, instale-o:
   ```bash
   sudo apt install -y git
   ```
2. Crie a pasta `Stage` no diretório home do usuário e clone o repositório:
   ```bash
   mkdir -p ~/Stage
   cd ~/Stage
   git clone https://github.com/rmacena/token-gd-ubuntu-mint.git
   cd token-gd-ubuntu-mint
   ```

### 3. Instale o pacote SafeSign para reconhedimento do token USB
1. Execute o script de instalação fornecido:
   ```bash
   chmod +x scripts/install-safesign.sh
   bash scripts/install-safesign.sh
   ```
   O script instalará as dependências, extrairá o SafeSign e instalará os pacotes necessários.

### 4. Configure o Firefox
O Firefox em formato Snap (padrão no Ubuntu 24.04) não é compatível com tokens. Substitua-o pela versão .deb executando o script de setup do Firefox:
1. Execute o script setup-firefox.sh:
   ```bash
   chmod +x scripts/setup-firefox.sh
   bash scripts/setup-firefox.sh
   ```
Se tudo correu bem, você conseguiu remover o pacote SNAP do Firefox, adicionar o repositório oficial do Mozzila e concluiu a instalação do Firefox.

2. Configure o Firefox para reconhecer o token:
   - Conecte o token G&D ao computador.
   - Abra o app Tokenadmin recem instalado, vá no menu **Integration > Install Safesign in Firefox**.
   - Clique em **firefox**, e em seguinda cliquem no botão **Install**.

### 5. Verifique o Funcionamento
1. Conecte o token G&D ao computador.
2. Abra o Firefox e acesse um site que exija certificado digital (ex.: [https://contas.acesso.gov.br](https://contas.acesso.gov.br)).
3. Se configurado corretamente, o Firefox solicitará a senha do token, e você obterá acesso com o selo ouro no gov.br.

## Solução de Problemas
- **Erro `CKR_DEVICE_ERROR`**: Verifique se o token está conectado e se o serviço `pcscd` está ativo:
  ```bash
  sudo systemctl enable pcscd.socket
  sudo systemctl start pcscd
  ```
- **Firefox não reconhece o token**: Confirme que a versão .deb do Firefox está instalada e que o arquivo `/usr/lib/libaetpkss.so.3` foi carregado corretamente.
- **Dependências ausentes**: Execute `sudo apt install -f` após cada instalação de pacote .deb.


## Como Contribuir
1. Faça um fork deste repositório.
2. Adicione melhorias, como suporte a outras distros ou otimizações no script.
3. Envie um pull request com suas alterações.

## Licença
Este projeto está licenciado sob a [MIT License](LICENSE).
