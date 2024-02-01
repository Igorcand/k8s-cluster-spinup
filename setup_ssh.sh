#!/bin/bash

# Caminho completo para o diretório .ssh
ssh_dir="$HOME/.ssh"

# Cria o diretório .ssh se ele não existir
mkdir "$ssh_dir"

# Extrai a chave privada do secrets do GitHub Actions e salva no arquivo k8s-key dentro de .ssh
echo "$PRIVATE_KEY" > "$ssh_dir/k8s-key"

# Ajusta as permissões do arquivo da chave privada
chmod 600 "$ssh_dir/k8s-key"

# Adiciona a chave ao agente SSH para permitir o acesso aos repositórios
eval "$(ssh-agent -s)"
ssh-add "$ssh_dir/k8s-key"
