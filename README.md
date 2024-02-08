# k8s-cluster-terraform-ansible-AWS

Esse é um projeto pessoal feito para a fixação dos conteúdos estudados sobre DevOps. Esse projeto utiliza o terraform para criar 3 instâncias EC2 na AWS, com o arquivo principarl do terraform .tfstate sendo armazenado em um S3. E depois, utilizando o ansible para acessar o IP dessas instâncias de forma dinâmica e aplicando playbooks e roles para configurar um cluster Kubernetes. Isso tudo de forma automática em um pipeline, no caso, o GitHub Actions.

# Tecnologias usadas #
 - Terraform
 - Ansible
 - Pipeline
 - AWS
- Linux

# Autor

Igor Cândido Rodrigues

https://www.linkedin.com/in/igorc%C3%A2ndido/