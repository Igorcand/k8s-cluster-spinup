terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "5.34.0"
        }
    }
}

//TODO: NÃO SUBIR ESSE ARQUIVO COM AS INFORMAÇÕES DE ACESS KEY E SECRET KEY
provider "aws" {
    region = "us-east-1"
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6/tLpsJNoWY7iThp9b99O5kBmCX1RxnchiBvAjasnSNcIH481KeeqZsVJx3zmZbbzkYqbDy2+wXA3U/k+SBZh8dPi6y4yJKT5Wsi/eugbjM6inSQg+Z6F3GMFRkfZUnMARHZ6QACqVFaYc24Q1EdnpzQuiSgj8IHkjUtG4BZ6Ra0lt4xCXLpuzO2kr57wsY2O/RYxhU9RDXI+QtzdSb63oDpae5NQokrmrJP1E58kApgMaVyYcjr1NPtFiZ/Gi97B8CUBrP5CHCE0oepX0pW1mL1mGes1wCiJ5HMZfXze4MNgLqDJmMpfdiiWLiYhSMuUKu003NJQRm3qE+MOeqEzrxrmm/PJrWSNXr8E20ZEY/Fsm+9Lqn6P1aEuPL9crt8phvcX9x1Y35lOsUlXfYNHlfW/Vl86xRakF38dCUnPabeaehTown9g+Kz68CYeac6I2ggThmzzMSMkofzI9xxoCB2Jo1NCNMC2ZuGR2E8MFxvXTYERubPT4ppD+1hhQWs= igorcr@igorcr"
}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "kubernetes-worker" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 2
  tags = {
    name = "k8s"
    type = "worker"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 1
  tags = {
    name = "k8s"
    type = "master"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}