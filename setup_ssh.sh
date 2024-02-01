#!/bin/bash

# Caminho completo para o diretório .ssh
ssh_dir="$HOME/.ssh"

# Cria o diretório .ssh se ele não existir
mkdir "$ssh_dir"

# Extrai a chave privada do secrets do GitHub Actions e salva no arquivo id_rsa dentro de .ssh
echo "$PRIVATE_KEY" > "$ssh_dir/id_rsa"

# Ajusta as permissões do arquivo da chave privada
chmod 600 "$ssh_dir/id_rsa"

# Adiciona a chave ao agente SSH para permitir o acesso aos repositórios
eval "$(ssh-agent -s)"
ssh-add "$ssh_dir/id_rsa"
