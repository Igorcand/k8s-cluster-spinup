#!/bin/bash

# Cria a pasta .ssh se ela não existir
mkdir -p ~/.ssh

cd .ssh/

# Extrai a chave privada do secrets do GitHub Actions
echo "${PRIVATE_KEY}" > ~/.ssh/id_rsa

# Ajusta as permissões do arquivo da chave privada
chmod 600 ~/.ssh/id_rsa

# Adiciona a chave ao agente SSH para permitir o acesso aos repositórios
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa