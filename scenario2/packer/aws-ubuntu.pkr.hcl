packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.0"
    }
    ansible = {
      source = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}

variable "vpc_id" {
  type = string
  default = ""
}

variable "subnet_id" {
  type = string
  default = ""
}

source "amazon-ebs" "ubuntu" {
  ami_name = "NoHands-ami-{{timestamp}}"
  instance_type = "t3.small"
  region        = "ap-northeast-2"
  source_ami    = "ami-0c1989c90aa86e7cf"
  ssh_username  = "ubuntu"

  vpc_id        = var.vpc_id
  subnet_id     = var.subnet_id
  associate_public_ip_address = true
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file = "../ansible/playbook.yml"
  }
}